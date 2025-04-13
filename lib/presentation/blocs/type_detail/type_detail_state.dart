import 'package:equatable/equatable.dart';
import 'package:pokedex/data/model_db/moves_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';
import 'package:pokedex/data/models/damage_relations_model.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_state.dart';
import 'package:pokedex/presentation/screens/pokemon_detail/detail_pokemon_model.dart';

class TypeDetailState extends Equatable {
  final List<Moves>? listMoves;
  final List<Pokemon>? listPokemon;
  final DamageRelationsModel? damageRelationsModel;
  final BlocPokemonStatus status;
  final String? error;

  const TypeDetailState({
    this.listMoves,
    this.listPokemon,
    this.damageRelationsModel,
    this.status = BlocPokemonStatus.initial,
    this.error,
  });

  factory TypeDetailState.initial() => const TypeDetailState(
        listMoves: null,
        listPokemon: null,
        damageRelationsModel: null,
        status: BlocPokemonStatus.initial,
      );

  TypeDetailState copyWith({
    List<Moves>? listDetailPokemonModel,
    List<Pokemon>? listPokemon,
    BlocPokemonStatus? status,
    DamageRelationsModel? damageRelationsModel,
    int? currentIndex,
    int? totalItems,
    String? error,
  }) {
    return TypeDetailState(
      listMoves: listMoves ?? listMoves,
      listPokemon: listPokemon ?? this.listPokemon,
      damageRelationsModel: damageRelationsModel ?? this.damageRelationsModel,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [listMoves, listPokemon, damageRelationsModel, status, error];
}
