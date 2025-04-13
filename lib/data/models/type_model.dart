import 'package:pokedex/theme/theme.dart';

import '../../import_global.dart';

class TypeModel {
  String value;
  String name;
  Color color;
  Color colorBackGround;
  SvgGenImage icon;
  SvgGenImage backGround;
  TypeModel({
    required this.value,
    required this.name,
    required this.color,
    required this.colorBackGround,
    required this.icon,
    required this.backGround,
  });
  // Static method to get a TypeModel by its value string
  static TypeModel getType(String type) {
    // Convert to lowercase for case-insensitive comparison
    final typeValue = type.toLowerCase();

    switch (typeValue) {
      case "grass":
        return TypeModelList.grass;
      case "fire":
        return TypeModelList.fire;
      case "normal":
        return TypeModelList.normal;
      case "fighting":
        return TypeModelList.fighting;
      case "flying":
        return TypeModelList.flying;
      case "poison":
        return TypeModelList.poison;
      case "ground":
        return TypeModelList.ground;
      case "rock":
        return TypeModelList.rock;
      case "bug":
        return TypeModelList.bug;
      case "ghost":
        return TypeModelList.ghost;
      case "steel":
        return TypeModelList.steel;
      case "water":
        return TypeModelList.water;
      case "electric":
        return TypeModelList.electric;
      case "psychic":
        return TypeModelList.psychic;
      case "ice":
        return TypeModelList.ice;
      case "dragon":
        return TypeModelList.dragon;
      case "dark":
        return TypeModelList.dark;
      case "fairy":
        return TypeModelList.fairy;
      default:
        return TypeModelList.normal; // Return null if type is not found
    }
  }
}

class TypeModelList {
  static TypeModel grass = TypeModel(
    value: "grass",
    name: "Grass",
    colorBackGround: TypeColors.grassBackGround,
    color: TypeColors.grass,
    icon: Assets.images.types.grass,
    backGround: Assets.images.types.background.grass,
  );

  static TypeModel fire = TypeModel(
    value: "fire",
    name: "Fire",
    colorBackGround: TypeColors.fireBackGround,
    color: TypeColors.fire,
    icon: Assets.images.types.fire,
    backGround: Assets.images.types.background.fire,
  );
  static TypeModel normal = TypeModel(
    value: "normal",
    name: "Normal",
    color: TypeColors.normal,
    colorBackGround: TypeColors.normalBackGround,
    icon: Assets.images.types.normal,
    backGround: Assets.images.types.background.normal,
  );
  static TypeModel fighting = TypeModel(
    value: "fighting",
    name: "Fighting",
    color: TypeColors.fighting,
    colorBackGround: TypeColors.fightingBackGround,
    icon: Assets.images.types.fighting,
    backGround: Assets.images.types.background.fighting,
  );
  static TypeModel flying = TypeModel(
    value: "flying",
    name: "Flying",
    color: TypeColors.flying,
    colorBackGround: TypeColors.flyingBackGround,
    icon: Assets.images.types.flying,
    backGround: Assets.images.types.background.flying,
  );
  static TypeModel poison = TypeModel(
    value: "poison",
    name: "Poison",
    color: TypeColors.poison,
    colorBackGround: TypeColors.poisonBackGround,
    icon: Assets.images.types.poison,
    backGround: Assets.images.types.background.poison,
  );
  static TypeModel ground = TypeModel(
    value: "ground",
    name: "Ground",
    color: TypeColors.ground,
    colorBackGround: TypeColors.groundBackGround,
    icon: Assets.images.types.ground,
    backGround: Assets.images.types.background.ground,
  );
  static TypeModel rock = TypeModel(
    value: "rock",
    name: "Rock",
    color: TypeColors.rock,
    colorBackGround: TypeColors.rockBackGround,
    icon: Assets.images.types.rock,
    backGround: Assets.images.types.background.rock,
  );
  static TypeModel bug = TypeModel(
    value: "bug",
    name: "Bug",
    color: TypeColors.bug,
    colorBackGround: TypeColors.bugBackGround,
    icon: Assets.images.types.bug,
    backGround: Assets.images.types.background.bug,
  );
  static TypeModel ghost = TypeModel(
    value: "ghost",
    name: "Ghost",
    color: TypeColors.ghost,
    colorBackGround: TypeColors.ghostBackGround,
    icon: Assets.images.types.ghost,
    backGround: Assets.images.types.background.ghost,
  );
  static TypeModel steel = TypeModel(
    value: "steel",
    name: "Steel",
    color: TypeColors.steel,
    colorBackGround: TypeColors.steelBackGround,
    icon: Assets.images.types.steel,
    backGround: Assets.images.types.background.steel,
  );
  static TypeModel water = TypeModel(
    value: "water",
    name: "Water",
    color: TypeColors.water,
    colorBackGround: TypeColors.waterBackGround,
    icon: Assets.images.types.water,
    backGround: Assets.images.types.background.water,
  );
  static TypeModel electric = TypeModel(
    value: "electric",
    name: "Electric",
    color: TypeColors.electric,
    colorBackGround: TypeColors.electricBackGround,
    icon: Assets.images.types.electric,
    backGround: Assets.images.types.background.electric,
  );
  static TypeModel psychic = TypeModel(
    value: "psychic",
    name: "Psychic",
    color: TypeColors.psychic,
    colorBackGround: TypeColors.psychicBackGround,
    icon: Assets.images.types.psychic,
    backGround: Assets.images.types.background.psychic,
  );
  static TypeModel ice = TypeModel(
    value: "ice",
    name: "Ice",
    color: TypeColors.ice,
    colorBackGround: TypeColors.iceBackGround,
    icon: Assets.images.types.ice,
    backGround: Assets.images.types.background.ice,
  );
  static TypeModel dragon = TypeModel(
    value: "dragon",
    name: "Dragon",
    color: TypeColors.dragon,
    colorBackGround: TypeColors.dragonBackGround,
    icon: Assets.images.types.dragon,
    backGround: Assets.images.types.background.dragon,
  );
  static TypeModel dark = TypeModel(
    value: "dark",
    name: "Dark",
    color: TypeColors.dark,
    colorBackGround: TypeColors.darkBackGround,
    icon: Assets.images.types.dart,
    backGround: Assets.images.types.background.dark,
  );
  static TypeModel fairy = TypeModel(
    value: "fairy",
    name: "Fairy",
    color: TypeColors.fairy,
    colorBackGround: TypeColors.fairy,
    icon: Assets.images.types.fairy,
    backGround: Assets.images.types.background.fairy,
  );
  static List<TypeModel> get allTypes => [
        grass,
        fire,
        normal,
        fighting,
        flying,
        poison,
        ground,
        rock,
        bug,
        ghost,
        steel,
        water,
        electric,
        psychic,
        ice,
        dragon,
        dark,
      ];

  /// ✅ Trả về số lượng type
  static int get count => allTypes.length;
}
