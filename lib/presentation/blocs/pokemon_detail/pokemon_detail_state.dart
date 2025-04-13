import 'package:equatable/equatable.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/detail_pokemon_model.dart';

enum BlocPokemonStatus { initial, loading, loaded, error }

class PokemonDetailState extends Equatable {
  final DetailPokemonModel? detailPokemonModel;
  final BlocPokemonStatus status;
  final String? error;

  const PokemonDetailState({
    this.detailPokemonModel,
    this.status = BlocPokemonStatus.initial,
    this.error,
  });

  factory PokemonDetailState.initial() => const PokemonDetailState(
        detailPokemonModel: null,
        status: BlocPokemonStatus.initial,
      );

  PokemonDetailState copyWith({
    DetailPokemonModel? detailPokemonModel,
    BlocPokemonStatus? status,
    BlocPokemonStatus? downloadDataPokemonStatus,
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
