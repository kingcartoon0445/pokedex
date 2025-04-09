import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // Từ JSON thành object
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  // Từ object thành JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}