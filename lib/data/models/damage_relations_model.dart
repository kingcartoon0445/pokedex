import 'package:pokedex/data/models/type_model.dart';

class DamageRelationsModel {
  final List<TypeModel> doubleDamageFrom;
  final List<TypeModel> doubleDamageTo;
  final List<TypeModel> halfDamageFrom;
  final List<TypeModel> halfDamageTo;
  final List<TypeModel> noDamageFrom;
  final List<TypeModel> noDamageTo;
  DamageRelationsModel({
    required this.doubleDamageFrom,
    required this.doubleDamageTo,
    required this.halfDamageFrom,
    required this.halfDamageTo,
    required this.noDamageFrom,
    required this.noDamageTo,
  });
  DamageRelationsModel copyWith({
    List<TypeModel>? doubleDamageFrom,
    List<TypeModel>? doubleDamageTo,
    List<TypeModel>? halfDamageFrom,
    List<TypeModel>? halfDamageTo,
    List<TypeModel>? noDamageFrom,
    List<TypeModel>? noDamageTo,
  }) {
    return DamageRelationsModel(
      doubleDamageFrom: doubleDamageFrom ?? this.doubleDamageFrom,
      doubleDamageTo: doubleDamageTo ?? this.doubleDamageTo,
      halfDamageFrom: halfDamageFrom ?? this.halfDamageFrom,
      halfDamageTo: halfDamageTo ?? this.halfDamageTo,
      noDamageFrom: noDamageFrom ?? this.noDamageFrom,
      noDamageTo: noDamageTo ?? this.noDamageTo,
    );
  }
}
