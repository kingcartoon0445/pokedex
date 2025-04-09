import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/data/datasources/local/database_db.dart';
import 'package:pokedex/data/datasources/local/map_data.dart';
import 'package:pokedex/data/model_db/evolution_chain_model.dart';
import 'package:pokedex/data/model_db/moves_model.dart';
import 'package:pokedex/data/repositories/user_repository.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_event.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/screens/%20pokemon_detail/detail_pokemon_model.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final PokemonRepository pokemonRepository;

  PokemonDetailBloc({required this.pokemonRepository})
      : super(const PokemonDetailState(detailPokemonModel: null)) {
    on<PokemonDetailGetAllDetail>(onPokemonDetailGetAllDetail);
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

  Future<void> onPokemonDetailGetAllDetail(
    PokemonDetailGetAllDetail event,
    Emitter<PokemonDetailState> emit,
  ) async {
    // try {
    final database = DatabaseHelper();
    // Khởi tạo danh sách Pokemon từ state hiện tại hoặc danh sách mới
    DetailPokemonModel detailPokemonModel =
        state.detailPokemonModel ?? DetailPokemonModel();
    List<Moves> listMoves = detailPokemonModel.listMoves ?? [];
    emit(const PokemonDetailState(
      // detailPokemonModel: detailPokemonModel,
      status: PokemonDetailStatus.loading,
    ));
    final responseList = await pokemonRepository.getAllDetailPokemon(event.id);
// Xử lý danh sách skill pokemon
    for (var element in responseList["pokemon_detail"]["moves"]) {
      var moves =
          await database.getMoveWithNameOrId(element["move"]["name"], null);
      if (moves.isNotEmpty) {
        listMoves.add(Moves.fromJson(moves[0]));
      }
    }

    var pokemonSpecies = responseList["pokemon_species"];
    String genus = "";
    List<String> eggGroups = [];
    for (var pokemonSpecy in pokemonSpecies["egg_groups"]) {
      eggGroups.add(pokemonSpecy["name"]);
    }
    for (var pokemonSpecy in pokemonSpecies["genera"]) {
      if (pokemonSpecy["language"]["name"] == "en") {
        genus = pokemonSpecy["genus"];
      }
    }

    var evolutionChain = responseList["evolution_chain"];
    var map = await _addPokemonKey(evolutionChain["chain"], database);
    saveJsonFile(map);
    // print("data map: $map");
    evolutionChain["chain"]["species"] = map;

    final evo = EvolutionChainModel.fromAPIJson(evolutionChain);
    // Update lại data UI
    detailPokemonModel = DetailPokemonModel(
        listMoves: listMoves,
        pokemon: event.pokemon,
        eggGroups: eggGroups,
        species: genus,
        evolutionChainModel: evo,
        genderRate: pokemonSpecies["gender_rate"] == -1
            ? -1
            : pokemonSpecies["gender_rate"] * 12.5,
        describe: pokemonSpecies["flavor_text_entries"][0]['flavor_text']);

    // responseList["pokemon_species"];
    // Hoàn thành quá trình tải dữ liệu
    emit(PokemonDetailState(
      detailPokemonModel: detailPokemonModel,
      status: PokemonDetailStatus.loaded,
    ));
    // } catch (e) {
    //   // Xử lý lỗi tổng thể
    //   print('Lỗi tổng thể khi tải danh sách Pokemon: $e');
    //   emit(PokemonDetailState(
    //     detailPokemonModel: state.detailPokemonModel,
    //     status: PokemonDetailStatus.error,
    //     error: e.toString(),
    //   ));
    // }
  }
}

Future<void> saveJsonFile(Map<String, dynamic> jsonData) async {
  // Lấy thư mục ứng dụng trên thiết bị
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/pokemon_data.json');

  // Chuyển đổi map sang chuỗi JSON
  String jsonString = jsonEncode(jsonData);

  // Lưu tệp JSON
  await file.writeAsString(jsonString);

  print('Tệp JSON đã được lưu tại: ${file.path}');
}
