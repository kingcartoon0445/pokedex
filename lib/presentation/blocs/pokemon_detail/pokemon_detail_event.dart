import 'package:equatable/equatable.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';

abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện kiểm tra trạng thái xác thực
class PokemonDetailGetAllDetail extends PokemonDetailEvent {
  final int id;
  final Pokemon pokemon;
  const PokemonDetailGetAllDetail({required this.id, required this.pokemon});
}

// Sự kiện kiểm tra trạng thái xác thực
class PokemonDetailDownLoadDataPokemonData extends PokemonDetailEvent {
  final int id;
  final int start;
  const PokemonDetailDownLoadDataPokemonData(
      {required this.id, required this.start});
}
