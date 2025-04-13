import 'package:pokedex/data/model_db/evolution_chain_model.dart';
import 'package:pokedex/data/model_db/moves_model.dart';
import 'package:pokedex/data/model_db/pokemon_model.dart';

class DetailPokemonModel {
  Pokemon? pokemon;
  String? describe;
  String? species;
  List<String>? eggGroups;
  double? genderRate;
  List<Moves>? listMoves;
  EvolutionChainModel? evolutionChainModel;

  DetailPokemonModel({
    this.pokemon,
    this.describe,
    this.species,
    this.eggGroups,
    this.genderRate,
    this.listMoves,
    this.evolutionChainModel,
  });

  /// Tạo bản sao của `DetailPokemonModel` với giá trị mới được cập nhật
  DetailPokemonModel copyWith({
    Pokemon? pokemon,
    String? describe,
    String? species,
    List<String>? eggGroups,
    double? genderRate,
    List<Moves>? listMoves,
    EvolutionChainModel? evolutionChainModel,
  }) {
    return DetailPokemonModel(
      pokemon: pokemon ?? this.pokemon,
      describe: describe ?? describe,
      species: species ?? species,
      eggGroups: eggGroups ?? eggGroups,
      genderRate: genderRate ?? genderRate,
      listMoves: listMoves ?? listMoves,
      evolutionChainModel: evolutionChainModel ?? evolutionChainModel,
    );
  }
}
