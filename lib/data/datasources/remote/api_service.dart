import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/core/api/api_endpoints.dart';
import 'package:pokedex/core/api/dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // Phương thức đăng nhập
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức đăng ký
  Future<Response> register(String name, String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiListPokemon() async {
    try {
      final response =
          await _dioClient.get(ApiEndpoints.urlListPokemon(3000, 0));
      saveJsonFile(response.data, "apiListPokemon"); // Lưu dữ liệu vào tệp JSON
      return response;
    } catch (e) {
      rethrow;
    }
  }

// id Generation
  Future<Response> apiListPokemonWithGeneration(String id) async {
    try {
      final response = await _dioClient
          .get(ApiEndpoints.urlListPokemonWithGeneration(id.toString()));
      saveJsonFile(response.data,
          "apiListPokemonWithGeneration"); // Lưu dữ liệu vào tệp JSON
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiDetailPokemon(String pokemonIdOrName) async {
    try {
      final response =
          await _dioClient.get(ApiEndpoints.urlDetailPokemon(pokemonIdOrName));
      saveJsonFile(
          response.data, "apiDetailPokemon"); // Lưu dữ liệu vào tệp JSON
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiDetailMove(String pokemonIdOrName) async {
    try {
      final response =
          await _dioClient.get(ApiEndpoints.urlDetailMove(pokemonIdOrName));
      saveJsonFile(response.data, "apiDetailMove"); // Lưu dữ liệu vào tệp JSON
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> apiGetURL(String url) async {
    final pokemonDetailResponse = await _dioClient.get(url);
    return pokemonDetailResponse.data;
  }

  Future<Map<String, dynamic>> apiAllDetailPokemon(
      String pokemonIdOrName) async {
    try {
      final pokemonDetailResponse =
          await _dioClient.get(ApiEndpoints.urlDetailPokemon(pokemonIdOrName));
      final pokemonSpeciesResponse =
          await _dioClient.get(ApiEndpoints.urlPokemonSpecies(pokemonIdOrName));

      // lấy api chuỗi tiến hoá từ api pokemonSpecies
      String urlEvolutionChain =
          pokemonSpeciesResponse.data["evolution_chain"]["url"];
      final evolutionChainResponse = await _dioClient.get(urlEvolutionChain);
//bắt đầu map data

      Map<String, dynamic> completeInfo = {
        "id": pokemonIdOrName,
        "pokemon_detail": pokemonDetailResponse.data,
        "pokemon_species": pokemonSpeciesResponse.data,
        "evolution_chain": evolutionChainResponse.data,
        // "detailed_moves": response4
      };
      saveJsonFile(completeInfo, "apiDetailMove"); // Lưu dữ liệu vào tệp JSON

      log("coplete info: $completeInfo");
      return completeInfo;
      // return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiPokemoneType(String typeIdOrName) async {
    try {
      final pokemonDetailResponse =
          await _dioClient.get(ApiEndpoints.urlPokemoneType(typeIdOrName));

      saveJsonFile(pokemonDetailResponse.data,
          "apiDetailMove"); // Lưu dữ liệu vào tệp JSON
      return pokemonDetailResponse;
      // return response;
    } catch (e) {
      rethrow;
    }
  }

  // Phương thức cập nhật thông tin người dùng
  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.updateProfile,
        data: data,
      );
      saveJsonFile(response.data, "apiDetailMove"); // Lưu dữ liệu vào tệp JSON
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Thêm các phương thức API khác tại đây
}

Future<void> saveJsonFile(
    Map<String, dynamic> jsonData, String nameFile) async {
  // Lấy thư mục ứng dụng trên thiết bị
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$nameFile.json');

  // Chuyển đổi map sang chuỗi JSON
  String jsonString = jsonEncode(jsonData);

  // Lưu tệp JSON
  await file.writeAsString(jsonString);

  print('Tệp JSON đã được lưu tại: ${file.path}');
}
