import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/datasources/local/database_db.dart';
import 'package:pokedex/data/datasources/local/map_data.dart';
import 'package:pokedex/data/model_db/generation_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/repositories/user_repository.dart';
import 'package:pokedex/presentation/blocs/home/home_event.dart';
import 'package:pokedex/presentation/blocs/home/home_state.dart';
import 'package:pokedex/presentation/screens/home/widget/list_sort_selection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PokemonRepository pokemonRepository;

  HomeBloc({required this.pokemonRepository})
      : super(HomeState(listPokemonModel: null)) {
    on<HomeGetListPokemon>(_onHomeGetListPokemon);
    on<HomeDownLoadDataPokemonData>(_onHomeDownloadDataPokemon);
  }

  // Xử lý sự kiện kiểm tra trạng thái xác thực
  Future<void> _onHomeGetListPokemon(
    HomeGetListPokemon event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // Khởi tạo danh sách Pokemon từ state hiện tại hoặc danh sách mới
      List<Pokemon> listPokemonModel = state.listPokemonModel != null
          ? List.from(state.listPokemonModel!)
          : [];
      List<GenerationModel> listGenerationModel =
          state.listGenerationModel != null
              ? List.from(state.listGenerationModel!)
              : [];

      // Thông báo bắt đầu tải dữ liệu
      emit(HomeState(
        listPokemonModel: listPokemonModel,
        status: HomeStatus.loading,
        listGenerationModel: listGenerationModel,
        downloadDataPokemonStatus: HomeStatus.initial,
        currentIndex: event.start,
        types: event.type,
        sortByType: event.sortByType,
        searchText: event.searchText,
        totalItems: event.count + event.start,
      ));

      // Tải từng Pokemon một và cập nhật UI ngay lập tức
      // Tải từng Pokémon một và cập nhật UI sau mỗi 10 Pokémon
      // int batchSize = 10; // Số lượng Pokémon trong mỗi lần cập nhật UI
      final database = DatabaseHelper();
      int count = await database.getCountPokemon(
          search: event.searchText, type: event.type);
      print("duýuy $count");
      String sortOrder = 'asc';
      String sortBy = 'id';
      switch (event.sortByType) {
        case SortByType.nameAsc:
          sortOrder = 'asc';
          sortBy = 'name';
          break;
        case SortByType.nameDesc:
          sortOrder = 'desc';
          sortBy = 'name';
          break;
        case SortByType.idAsc:
          sortOrder = 'asc';
          sortBy = 'id';
          break;
        case SortByType.idDesc:
          sortOrder = 'desc';
          sortBy = 'id';
          break;
        default:
          break;
      }
      final detailPokemonModel = await database.getPokemon(
          search: event.searchText,
          startIndex: event.start,
          limit: event.count,
          type: event.type,
          sortBy: sortBy,
          sortOrder: sortOrder,
          prioritizeTypeOrder: event.sortByType != null ? false : true);
      if (event.start == 0) {
        List<Pokemon> list = [];
        for (int i = 0; i < detailPokemonModel.length; i++) {
          list.add(Pokemon.fromJson(detailPokemonModel[i]));
        }
        listPokemonModel = [];
        listPokemonModel = list;
      } else {
        for (int i = 0; i < detailPokemonModel.length; i++) {
          listPokemonModel.add(Pokemon.fromJson(detailPokemonModel[i]));
        }
      }
      final generationModel = await database.selectData("generation");
      List<GenerationModel> list = [];
      for (int i = 0; i < generationModel.length; i++) {
        list.add(GenerationModel.fromJson(generationModel[i]));
      }
      listGenerationModel = list;

      // Hoàn thành quá trình tải dữ liệu
      emit(HomeState(
        listPokemonModel: listPokemonModel,
        listGenerationModel: listGenerationModel,
        status: HomeStatus.loaded,
        types: state.types,
        countSearch: count,
        sortByType: event.sortByType,
        searchText: event.searchText,
        currentIndex: event.count + event.start,
        totalItems: event.count + event.start,
      ));
    } catch (e) {
      // Xử lý lỗi tổng thể
      print('Lỗi tổng thể khi tải danh sách Pokemon: $e');
      emit(HomeState(
        listPokemonModel: state.listPokemonModel,
        listGenerationModel: state.listGenerationModel,
        status: HomeStatus.error,
        error: e.toString(),
      ));
    }
  }

  int batchSize = 10;
  Future<void> _onHomeDownloadDataPokemon(
    HomeDownLoadDataPokemonData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final database = DatabaseHelper();
      // Khởi tạo danh sách Pokemon từ state hiện tại hoặc danh sách mới
      List<Pokemon> listPokemonModel = state.listPokemonModel != null
          ? List.from(state.listPokemonModel!)
          : [];
      final responseList = await pokemonRepository
          .getListPokemonWithGeneration(event.id.toString());
      List<dynamic> pokemonSpecies = responseList["pokemon_species"];

      List<dynamic> moves = responseList["moves"];
      List<String> listMoves = [];
      List<String> listPokemonName = [];
      for (int i = 0; i < moves.length; i++) {
        listMoves.add(moves[i]["name"]);
      }

      for (int i = 0; i < pokemonSpecies.length; i++) {
        listPokemonName.add(pokemonSpecies[i]["name"]);
      }
      int count = listPokemonName.length + moves.length;
      // Thông báo bắt đầu tải dữ liệu
      emit(state.copyWith(
        downloadDataPokemonStatus: HomeStatus.loading,
        idGenDown: event.id,
        currentIndex: 1,
        totalItems: count,
      ));

      bool isDownMoveDone =
          await getMovesWithGeneration(listMoves, database, emit);
      if (isDownMoveDone == true) {
        log("Done Download Moves");
      } else {
        log("Error Download Moves");
      }
      // Tải từng Pokemon một và cập nhật UI ngay lập tức
      // Tải từng Pokémon một và cập nhật UI sau mỗi 10 Pokémon
      // Số lượng Pokémon trong mỗi lần cập nhật UI

      for (int i = 0; i < listPokemonName.length; i++) {
        try {
          // listPokemonModel["results"]
          final detailPokemonModel = await pokemonRepository
              .getResponseDetailPokemon(listPokemonName[i]);
          // Thêm Pokémon mới vào danh sách
          // listPokemonModel.add(detailPokemonModel);
          database.insertOrUpdate("pokemon",
              MapjsonDB.toJsonDBPokemonTable(detailPokemonModel), "Id");
          // Kiểm tra nếu đã tải đủ 10 Pokémon hoặc đã đến Pokémon cuối cùng trong đợt tải
          if ((i + 1) % batchSize == 0 || i == listPokemonName.length - 1) {
            // if (i >= event.count + event.start - 1) {
            //   var list = database.getAllPokemon();
            // }
            // Emit state mới sau khi tải đủ 10 Pokémon hoặc nếu đã tải xong tất cả
            emit(state.copyWith(
              listPokemonModel: listPokemonModel,
              downloadDataPokemonStatus: i < listPokemonName.length - 1
                  ? HomeStatus.loading
                  : HomeStatus.loaded,
              currentIndex: i + listMoves.length,
              totalItems: count,
            ));
            if (i < listPokemonName.length - 1) {
              database.updateDownloaded(event.id, true);
            }
          }
        } catch (pokemonError) {
          // Xử lý lỗi cho từng Pokémon riêng lẻ, nhưng tiếp tục với Pokémon tiếp theo
          print('Lỗi khi tải Pokémon $i: $pokemonError');
          // Tùy chọn: Có thể emit state để hiển thị lỗi cho Pokémon cụ thể này
        }
      }

      // Hoàn thành quá trình tải dữ liệu
      emit(state.copyWith(
        listPokemonModel: listPokemonModel,
        downloadDataPokemonStatus: HomeStatus.loaded,
        currentIndex: count,
        totalItems: count,
      ));
    } catch (e) {
      // Xử lý lỗi tổng thể
      print('Lỗi tổng thể khi tải danh sách Pokemon: $e');
      emit(state.copyWith(
        listPokemonModel: state.listPokemonModel,
        downloadDataPokemonStatus: HomeStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<bool> getMovesWithGeneration(List<String> listMoves,
      DatabaseHelper database, Emitter<HomeState> emit) async {
    try {
      for (int i = 1; i < listMoves.length; i++) {
        try {
          // listPokemonModel["results"]
          final detailPokemonModel =
              await pokemonRepository.getResponseDetailMove(listMoves[i]);
          // Thêm Pokémon mới vào danh sách
          // listPokemonModel.add(detailPokemonModel);
          database.insertOrUpdate(
              "moves", MapjsonDB.toJsonDBMovesTable(detailPokemonModel), "Id");
          // Kiểm tra nếu đã tải đủ 10 Pokémon hoặc đã đến Pokémon cuối cùng trong đợt tải
          if ((i + 1) % batchSize == 0 || i == listMoves.length - 1) {
            emit(state.copyWith(
              // downloadDataPokemonStatus: HomeStatus.loading,
              currentIndex: i,
            ));
          }
        } catch (pokemonError) {
          // Xử lý lỗi cho từng Pokémon riêng lẻ, nhưng tiếp tục với Pokémon tiếp theo
          print('Lỗi khi tải Pokémon $i: $pokemonError');
          // Tùy chọn: Có thể emit state để hiển thị lỗi cho Pokémon cụ thể này
          return false;
        }
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Future<void> _onGetGenerationPokemon(
  //   HomeGetGenerationPokemonData event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   try {
  //     final database = DatabaseHelper();
  //     // Khởi tạo danh sách Pokemon từ state hiện tại hoặc danh sách mới
  //     List<Pokemon> listPokemonModel = state.listPokemonModel != null
  //         ? List.from(state.listPokemonModel!)
  //         : [];
  //     final responseList =
  //         await pokemonRepository.getListPokemonWithGeneration("");
  //     List<dynamic> pokemonSpecies = responseList["results"];

  //     List<dynamic> moves = responseList["moves"];
  //     List<String> listMoves = [];
  //     List<String> listPokemonName = [];
  //     for (int i = 0; i < moves.length; i++) {
  //       listMoves.add(moves[i]["name"]);
  //     }

  //     for (int i = 0; i < pokemonSpecies.length; i++) {
  //       listPokemonName.add(pokemonSpecies[i]["name"]);
  //     }
  //     int count = listPokemonName.length + moves.length;
  //     // Thông báo bắt đầu tải dữ liệu
  //     emit(HomeState(
  //       downloadDataPokemonStatus: HomeStatus.loading,
  //       currentIndex: event.start,
  //       totalItems: count,
  //     ));

  //     bool isDownMoveDone =
  //         await getMovesWithGeneration(listMoves, database, emit);
  //     if (isDownMoveDone == true) {
  //       log("Done Download Moves");
  //     }
  //     // Tải từng Pokemon một và cập nhật UI ngay lập tức
  //     // Tải từng Pokémon một và cập nhật UI sau mỗi 10 Pokémon
  //     // Số lượng Pokémon trong mỗi lần cập nhật UI

  //     for (int i = 0; i < listPokemonName.length; i++) {
  //       try {
  //         // listPokemonModel["results"]
  //         final detailPokemonModel = await pokemonRepository
  //             .getResponseDetailPokemon(listPokemonName[i]);
  //         // Thêm Pokémon mới vào danh sách
  //         // listPokemonModel.add(detailPokemonModel);
  //         database.insertOrUpdate("pokemon",
  //             MapjsonDB.toJsonDBPokemonTable(detailPokemonModel), "Id");
  //         // Kiểm tra nếu đã tải đủ 10 Pokémon hoặc đã đến Pokémon cuối cùng trong đợt tải
  //         if ((i + 1) % batchSize == 0 || i == listPokemonName.length - 1) {
  //           // if (i >= event.count + event.start - 1) {
  //           //   var list = database.getAllPokemon();
  //           // }
  //           // Emit state mới sau khi tải đủ 10 Pokémon hoặc nếu đã tải xong tất cả
  //           emit(HomeState(
  //             listPokemonModel: listPokemonModel,
  //             downloadDataPokemonStatus: i < listPokemonName.length - 1
  //                 ? HomeStatus.loading
  //                 : HomeStatus.loaded,
  //             currentIndex: i + listMoves.length,
  //             totalItems: count,
  //           ));
  //           // if (i >= event.count + event.start - 1) {
  //           //   _onHomeGetLocalPokemonData(emit);
  //           // }
  //         }
  //       } catch (pokemonError) {
  //         // Xử lý lỗi cho từng Pokémon riêng lẻ, nhưng tiếp tục với Pokémon tiếp theo
  //         print('Lỗi khi tải Pokémon $i: $pokemonError');
  //         // Tùy chọn: Có thể emit state để hiển thị lỗi cho Pokémon cụ thể này
  //       }
  //     }

  //     // Hoàn thành quá trình tải dữ liệu
  //     emit(HomeState(
  //       listPokemonModel: listPokemonModel,
  //       downloadDataPokemonStatus: HomeStatus.loaded,
  //       currentIndex: count,
  //       totalItems: count,
  //     ));
  //   } catch (e) {
  //     // Xử lý lỗi tổng thể
  //     print('Lỗi tổng thể khi tải danh sách Pokemon: $e');
  //     emit(HomeState(
  //       listPokemonModel: state.listPokemonModel,
  //       downloadDataPokemonStatus: HomeStatus.error,
  //       error: e.toString(),
  //     ));
  //   }
  // }
}
