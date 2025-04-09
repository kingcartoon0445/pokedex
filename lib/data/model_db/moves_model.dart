class Moves {
  final int id;
  final String name;
  final double power;
  final double pp;
  final String type;

  Moves({
    required this.id,
    required this.name,
    required this.power,
    required this.pp,
    required this.type,
  });
  // Chuyển từ Map (JSON) sang đối tượng Moves
  factory Moves.fromJson(Map<String, dynamic> json) {
    return Moves(
      id: json['Id'] as int,
      name: json['Name'] as String,
      power: json['Power'] == null ? 0 : (json['Power'] as num).toDouble(),
      pp: (json['Pp'] as num).toDouble(),
      type: json['Type'] as String,
    );
  }

  // Chuyển từ đối tượng Moves sang Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Power': power,
      'Pp': pp,
      'Type': type,
    };
  }

  factory Moves.fromMapData(Map<String, dynamic> map) {
    return Moves(
      id: map['id'],
      name: map['name'],
      power:
          map['power'] is int ? (map['power'] as int).toDouble() : map['power'],
      pp: map['pp'] is int ? (map['pp'] as int).toDouble() : map['pp'],
      type: map['type']['name'],
    );
  }
}
