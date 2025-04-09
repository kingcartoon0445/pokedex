import 'package:equatable/equatable.dart';
import 'package:pokedex/presentation/screens/%20pokemon_detail/detail_pokemon_model.dart';

enum PokemonDetailStatus { initial, loading, loaded, error }

class PokemonDetailState extends Equatable {
  final DetailPokemonModel? detailPokemonModel;
  final PokemonDetailStatus status;
  final String? error;

  const PokemonDetailState({
    this.detailPokemonModel,
    this.status = PokemonDetailStatus.initial,
    this.error,
  });

  factory PokemonDetailState.initial() => const PokemonDetailState(
        detailPokemonModel: null,
        status: PokemonDetailStatus.initial,
      );

  PokemonDetailState copyWith({
    DetailPokemonModel? detailPokemonModel,
    PokemonDetailStatus? status,
    PokemonDetailStatus? downloadDataPokemonStatus,
    int? currentIndex,
    int? totalItems,
    String? error,
  }) {
    return PokemonDetailState(
      detailPokemonModel: detailPokemonModel ?? this.detailPokemonModel,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [detailPokemonModel, status, error];
}
