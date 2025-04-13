import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/datasources/local/database_db.dart';
import 'package:pokedex/data/datasources/local/map_data.dart';
import 'package:pokedex/data/model_db/moves_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/models/damage_relations_model.dart';
import 'package:pokedex/data/models/type_model.dart';
import 'package:pokedex/data/repositories/user_repository.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_event.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_state.dart';

class TypeDetailBloc extends Bloc<TypeDetailEvent, TypeDetailState> {
  final PokemonRepository pokemonRepository;

  TypeDetailBloc({required this.pokemonRepository})
      : super(const TypeDetailState(listPokemon: [], listMoves: [])) {
    on<GetTypeDetai>(onGetTypeDetail);
  }

  int batchSize = 10;
  // Future<Map<String, dynamic>> addPokemonField(
  //     Map<String, dynamic> evolutionChain, DatabaseHelper database) async {
  //   Map<String, dynamic> updatedChain = Map.from(evolutionChain);
  //   // Thêm trường "pokemon" vào species
  //   List<Map<String, dynamic>> pokemones = await database
  //       .getPokemonWithNameOrId(evolutionChain["species"]["name"], null);
  //   if (pokemones.isNotEmpty) {
  //     updatedChain["species"]["pokemon"] = pokemones[0];
  //     updatedChain["evolves_to"] = (updatedChain["evolves_to"] as List)
  //         .map((evolution) => addPokemonField(evolution, database))
  //         .toList();
  //   }

  //   return updatedChain;
  // }
  Future<Map<String, dynamic>> _addPokemonKey(
      Map<String, dynamic> jsonData, DatabaseHelper database) async {
    // Hàm đệ quy để thêm key "pokemon": thông tin về Pokémon vào species

    // Lấy Pokemon từ cơ sở dữ liệu dựa trên tên species
    List<Map<String, dynamic>> pokemones = await database
        .getPokemonWithNameOrId(jsonData["species"]["name"], null);

    if (jsonData.containsKey("known_move")) {
      if (jsonData['known_move'] != null) {
        List<Map<String, dynamic>> move = await database.getMoveWithNameOrId(
            jsonData['known_move']["name"], null);
      }
    }

    // Nếu tìm thấy Pokemon, thêm vào jsonData dưới key "pokemon"
    if (pokemones.isNotEmpty) {
      jsonData["pokemon"] = pokemones[0];
    } else {
      String url = jsonData["species"]["url"];
      final id = url.split('/').where((e) => e.isNotEmpty).last;
      final detailPokemonModel =
          await pokemonRepository.getResponseDetailPokemon(id);
      jsonData["pokemon"] = MapjsonDB.toJsonDBPokemonTable(detailPokemonModel);
    }

    // Kiểm tra và xử lý trường hợp có tiến hóa
    if (jsonData.containsKey("evolves_to")) {
      for (var evolution in jsonData["evolves_to"]) {
        // Đệ quy cho từng phần tử trong evolves_to để thêm thông tin Pokemon
        await _addPokemonKey(evolution, database);

        // Kiểm tra nếu có tiến hóa thêm nữa
        if (evolution.containsKey("evolves_to")) {
          for (var subEvolution in evolution["evolves_to"]) {
            subEvolution["pokemon"] =
                await _addPokemonKey(subEvolution, database);
          }
        }
      }
    }

    // Sao chép dữ liệu để tránh sửa đổi trực tiếp
    Map<String, dynamic> modifiedJson = Map.from(jsonData);

    return modifiedJson;
  }

  List<TypeModel> getListType(List<dynamic> damegeRelations) {
    List<TypeModel> listType = [];
    for (var value in damegeRelations) {
      String name = value["name"];
      listType.add(TypeModel.getType(name));
    }
    return listType;
  }

  Future<void> onGetTypeDetail(
    GetTypeDetai event,
    Emitter<TypeDetailState> emit,
  ) async {
    // try {

    final database = DatabaseHelper();
    List<Pokemon> listPokemon = []; //List.of(state.listPokemon ?? []);
    List<Moves> moves = []; // List.of(state.listMoves ?? []);

    DamageRelationsModel damageRelationsModel = state.damageRelationsModel ??
        DamageRelationsModel(
          doubleDamageFrom: [],
          halfDamageFrom: [],
          noDamageFrom: [],
          doubleDamageTo: [],
          halfDamageTo: [],
          noDamageTo: [],
        );
    emit(const TypeDetailState(
      // detailPokemonModel: detailPokemonModel,
      status: BlocPokemonStatus.loading,
    ));
    // Khởi tạo danh sách Pokemon từ state hiện tại hoặc danh sách mới
    final responseList =
        await pokemonRepository.getPokemoneType(event.typeIdOrName);
    // lấy danh sách pokemon từ api
    for (var value in responseList["pokemon"]) {
      String name = value["pokemon"]["name"];
      List<Map<String, dynamic>> pokemones =
          await database.getPokemonWithNameOrId(name, null);
      if (pokemones.isNotEmpty) {
        listPokemon.add(Pokemon.fromJson(pokemones[0]));
      }
    }
    // lấy danh sách skill từ api
    for (var value in responseList["moves"]) {
      String name = value["name"];
      List<Map<String, dynamic>> move =
          await database.getMoveWithNameOrId(name, null);
      if (move.isNotEmpty) {
        moves.add(Moves.fromJson(move[0]));
      }
    }
    var damegeRelations = responseList["damage_relations"];

    damageRelationsModel.copyWith(
      doubleDamageFrom: getListType(damegeRelations["double_damage_from"]),
      doubleDamageTo: getListType(damegeRelations["double_damage_to"]),
      halfDamageFrom: getListType(damegeRelations["half_damage_from"]),
      halfDamageTo: getListType(damegeRelations["half_damage_to"]),
      noDamageFrom: getListType(damegeRelations["no_damage_from"]),
      noDamageTo: getListType(damegeRelations["no_damage_to"]),
    );
    emit(TypeDetailState(
      listPokemon: listPokemon,
      listMoves: moves,
      damageRelationsModel: damageRelationsModel,
      status: BlocPokemonStatus.loaded,
    ));
    // } catch (e) {
    //   // Xử lý lỗi tổng thể
    //   print('Lỗi tổng thể khi tải danh sách Pokemon: $e');
    //   emit(TypeDetailState(
    //     detailPokemonModel: state.detailPokemonModel,
    //     status: TypeDetailStatus.error,
    //     error: e.toString(),
    //   ));
    // }
  }
}
