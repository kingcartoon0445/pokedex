class MapjsonDB {
  static Map<String, dynamic> toJsonDBPokemonTable(Map<String, dynamic> map) {
    List<String> types = map['types'] != null
        ? (map['types'] as List<dynamic>)
            .map((typeData) => typeData['type']['name'] as String)
            .toList()
        : [];
    return {
      "Id": map['id'],
      'Name': map['name'],
      'Height': map['height'] is int
          ? (map['height'] as int).toDouble()
          : map['height'],
      'Weight': map['weight'] is int
          ? (map['weight'] as int).toDouble()
          : map['weight'],
      'Image': map['sprites']['other']['home']['front_default'],
      'Hp': map['stats'][0]['base_stat'],
      'Attack': map['stats'][1]['base_stat'],
      'Defense': map['stats'][2]['base_stat'],
      'Special_attack': map['stats'][3]['base_stat'],
      'Special_defense': map['stats'][4]['base_stat'],
      'Speed': map['stats'][5]['base_stat'],
      'Type1': types.isNotEmpty ? types[0] : null,
      'Type2': types.length > 1 ? types[1] : null,
    };
  }

  static Map<String, dynamic> toJsonDBMovesTable(Map<String, dynamic> map) {
    return {
      "Id": map['id'],
      "Name": map['name'],
      "Power":
          map['power'] is int ? (map['power'] as int).toDouble() : map['power'],
      "Pp": map['pp'] is int ? (map['pp'] as int).toDouble() : map['pp'],
      "Type": map['type']['name']
    };
  }
}
