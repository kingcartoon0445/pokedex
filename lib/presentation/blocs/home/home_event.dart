import 'package:equatable/equatable.dart';
import 'package:pokedex/presentation/screens/home/widget/list_sort_selection.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện kiểm tra trạng thái xác thực
class HomeGetListPokemon extends HomeEvent {
  final int start;
  final int count;
  final List<String> type;
  final String? searchText;
  final SortByType? sortByType;
  const HomeGetListPokemon({
    required this.count,
    required this.start,
    this.type = const [],
    this.searchText = "",
    this.sortByType,
  });
}

// Sự kiện kiểm tra trạng thái xác thực
class HomeDownLoadDataPokemonData extends HomeEvent {
  final int id;
  final int start;
  const HomeDownLoadDataPokemonData({required this.id, required this.start});
}

class HomeGetGenerationPokemonData extends HomeEvent {
  // const HomeGetGenerationPokemonData({ });
}
