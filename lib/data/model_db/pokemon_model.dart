class Pokemon {
  final int id;
  final String name;
  final double height;
  final double weight;
  final String image;
  final num? hp;
  final num? attack;
  final num? defense;
  final num? specialAttack;
  final num? specialDefense;
  final num? speed;
  final num? total;
  final List<String> type;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.image,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.total,
    required this.type,
  });
  // Chuyển từ Map (JSON) sang đối tượng Pokemon
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['Id'] as int,
      name: json['Name'] as String,
      height: (json['Height'] as num).toDouble(),
      weight: (json['Weight'] as num).toDouble(),
      image: json['Image'] as String,
      hp: json['Hp'] as int,
      attack: json['Attack'] as int,
      defense: json['Defense'] as int,
      specialAttack: json['Special_attack'] as int,
      specialDefense: json['Special_defense'] as int,
      speed: json['Speed'] as int,
      total: json['Hp'] +
          json['Attack'] +
          json['Defense'] +
          json['Special_attack'] +
          json['Special_defense'] +
          json['Speed'],
      type: [
        if (json['Type1'] != null) json['Type1'] as String,
        if (json['Type2'] != null) json['Type2'] as String,
      ],
    );
  }

  // Chuyển từ đối tượng Pokemon sang Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Height': height,
      'Weight': weight,
      'Image': image,
      'Hp': hp,
      'Attack': attack,
      'Defense': defense,
      'Special_attack': specialAttack,
      'Special_defense': specialDefense,
      'Speed': speed,
      'Type1': type.isNotEmpty ? type[0] : null,
      'Type2': type.length > 1 ? type[1] : null,
    };
  }

  factory Pokemon.fromMapData(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'],
      name: map['name'],
      height: map['height'] is int
          ? (map['height'] as int).toDouble()
          : map['height'],
      weight: map['weight'] is int
          ? (map['weight'] as int).toDouble()
          : map['weight'],
      image: map['sprites']['other']['home']['front_default'],
      hp: map['stats'][0]['base_stat'],
      attack: map['stats'][1]['base_stat'],
      defense: map['stats'][2]['base_stat'],
      specialAttack: map['stats'][3]['base_stat'],
      specialDefense: map['stats'][4]['base_stat'],
      total: map['stats'][0]['base_stat'] +
          map['stats'][1]['base_stat'] +
          map['stats'][2]['base_stat'] +
          map['stats'][3]['base_stat'] +
          map['stats'][4]['base_stat'] +
          map['stats'][5]['base_stat'],
      speed: map['stats'][5]['base_stat'],
      type: (map['types'] as List<dynamic>)
          .map((typeData) => typeData['type']['name'] as String)
          .toList(),
    );
  }
}
