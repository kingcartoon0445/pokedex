import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokedex/core/error/exceptions.dart';
import 'package:pokedex/data/datasources/local/storage_service.dart';
import 'package:pokedex/data/datasources/remote/api_service.dart';
import 'package:pokedex/data/models/user_model.dart';

class UserRepository {
  final ApiService apiService;
  final StorageService storageService;

  UserRepository({
    required this.apiService,
    required this.storageService,
  });

  // Phương thức đăng nhập
  Future<UserModel> login(String email, String password) async {
    try {
      // Gọi API đăng nhập
      final response = await apiService.login(email, password);

      // Lưu token vào bộ nhớ cục bộ
      final token = response.data['token'];
      await storageService.setToken(token);

      // Lưu user ID vào bộ nhớ cục bộ
      final user = UserModel.fromJson(response.data['user']);
      await storageService.setUserId(user.id);

      return user;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi đăng nhập',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  // Phương thức đăng ký
  Future<UserModel> register(String name, String email, String password) async {
    try {
      // Gọi API đăng ký
      final response = await apiService.register(name, email, password);

      // Lưu token vào bộ nhớ cục bộ
      final token = response.data['token'];
      await storageService.setToken(token);

      // Lưu user ID vào bộ nhớ cục bộ
      final user = UserModel.fromJson(response.data['user']);
      await storageService.setUserId(user.id);

      return user;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi đăng ký',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  // Phương thức lấy thông tin người dùng
  // Future<UserModel> getUserProfile() async {
  //   try {
  //     // final response = await apiService.getUserProfile();
  //     return UserModel.fromJson(response.data['user']);
  //   } on DioException catch (e) {
  //     throw ServerException(
  //       message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
  //       statusCode: e.response?.statusCode ?? 0,
  //     );
  //   }
  // }

  // Phương thức đăng xuất
  Future<void> logout() async {
    await storageService.removeToken();
    await storageService.removeUserId();
  }

  // Kiểm tra xem người dùng đã đăng nhập chưa
  bool isLoggedIn() {
    final token = storageService.getToken();
    return token != null && token.isNotEmpty;
  }
}
