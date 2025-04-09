import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokedex/core/error/exceptions.dart';
import 'package:pokedex/data/datasources/local/storage_service.dart';
import 'package:pokedex/data/datasources/remote/api_service.dart';
import 'package:pokedex/data/models/detail_pokemon_model.dart';
import 'package:pokedex/data/models/list_pokemon_model.dart';
import 'package:pokedex/data/models/user_model.dart';

class PokemonRepository {
  final ApiService apiService;
  final StorageService storageService;

  PokemonRepository({
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

  // // Phương thức lấy thông tin người dùng
  // Future<UserModel> getUserProfile() async {
  //   try {
  //     final response = await apiService.apiUserProfile();
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

  // Phương thức lấy thông tin người dùng
  Future<Map<String, dynamic>> getListPokemon() async {
    try {
      final response = await apiService.apiListPokemon();

      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  // Lấy danh sách pokemon theo từ thế hệ
  Future<Map<String, dynamic>> getListPokemonWithGeneration(String id) async {
    try {
      final response = await apiService.apiListPokemonWithGeneration(id);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  // Future<DetailPokemonModel> getDetailPokemon(String getDetailPokemon) async {
  //   try {
  //     final response = await apiService.apiDetailPokemon(getDetailPokemon);

  //     DetailPokemonModel data = DetailPokemonModel.fromJson(response.data);
  //     return data;
  //   } on DioException catch (e) {
  //     throw ServerException(
  //       message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
  //       statusCode: e.response?.statusCode ?? 0,
  //     );
  //   }
  // }

  Future<Map<String, dynamic>> getResponseDetailPokemon(
      String getDetailPokemon) async {
    try {
      final response = await apiService.apiDetailPokemon(getDetailPokemon);

      // DetailPokemonModel data = DetailPokemonModel.fromJson(response.data);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  Future<Map<String, dynamic>> getResponseDetailMove(
      String getDetailPokemon) async {
    try {
      final response = await apiService.apiDetailMove(getDetailPokemon);

      // DetailPokemonModel data = DetailPokemonModel.fromJson(response.data);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  Future<Map<String, dynamic>> getAllDetailPokemon(int getDetailPokemon) async {
    try {
      final response =
          await apiService.apiAllDetailPokemon(getDetailPokemon.toString());
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  Future<Map<String, dynamic>> getApiGetURL(String getDetailPokemon) async {
    try {
      final response = await apiService.apiGetURL(getDetailPokemon.toString());
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Lỗi lấy thông tin',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }
}
