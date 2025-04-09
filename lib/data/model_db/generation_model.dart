class GenerationModel {
  int id;
  String name;
  bool downloaded;

  GenerationModel({
    required this.id,
    required this.name,
    required this.downloaded,
  });

  // fromJson constructor
  factory GenerationModel.fromJson(Map<String, dynamic> json) {
    return GenerationModel(
      id: json['Id'] as int,
      name: json['Name'] as String,
      downloaded: (json['Downloaded'] ?? 0) == 1, // nếu dùng SQLite dạng int
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Downloaded': downloaded ? 1 : 0, // SQLite không có kiểu boolean
    };
  }

  // copyWith method
  GenerationModel copyWith({
    int? id,
    String? name,
    bool? downloaded,
  }) {
    return GenerationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      downloaded: downloaded ?? this.downloaded,
    );
  }
}
