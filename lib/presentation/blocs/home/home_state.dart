import 'package:equatable/equatable.dart';
import 'package:pokedex/data/model_db/generation_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/presentation/screens/home/widget/list_sort_selection.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final List<Pokemon>? listPokemonModel;
  final List<GenerationModel>? listGenerationModel;
  final HomeStatus status;
  final HomeStatus downloadDataPokemonStatus;
  final int currentIndex;
  final int totalItems;
  final int idGenDown;
  final int countSearch;
  final SortByType? sortByType;
  List<String> types;
  final String? searchText;
  final String? error;

  HomeState({
    this.listPokemonModel,
    this.listGenerationModel,
    this.status = HomeStatus.initial,
    this.downloadDataPokemonStatus = HomeStatus.initial,
    this.currentIndex = 0,
    this.countSearch = 0,
    this.totalItems = 0,
    this.idGenDown = 0,
    this.sortByType,
    this.searchText,
    this.types = const [],
    this.error,
  });

  factory HomeState.initial() => HomeState(
        listPokemonModel: null,
        listGenerationModel: null,
        status: HomeStatus.initial,
      );

  HomeState copyWith({
    List<Pokemon>? listPokemonModel,
    List<GenerationModel>? listGenerationModel,
    HomeStatus? status,
    HomeStatus? downloadDataPokemonStatus,
    int? idGenDown,
    int? currentIndex,
    int? totalItems,
    int? countSearch,
    SortByType? sortByType,
    String? searchText,
    List<String>? type,
    String? error,
  }) {
    return HomeState(
      listPokemonModel: listPokemonModel ?? this.listPokemonModel,
      listGenerationModel: listGenerationModel ?? this.listGenerationModel,
      status: status ?? this.status,
      downloadDataPokemonStatus:
          downloadDataPokemonStatus ?? this.downloadDataPokemonStatus,
      countSearch: countSearch ?? this.countSearch,
      idGenDown: idGenDown ?? this.idGenDown,
      currentIndex: currentIndex ?? this.currentIndex,
      totalItems: totalItems ?? this.totalItems,
      searchText: searchText ?? this.searchText,
      sortByType: sortByType ?? this.sortByType,
      types: type ?? types,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        listPokemonModel,
        listGenerationModel,
        status,
        currentIndex,
        totalItems,
        idGenDown,
        searchText,
        sortByType,
        types,
        error
      ];
}
