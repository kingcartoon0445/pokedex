import 'dart:developer';

import 'package:dio/dio.dart';
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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiDetailPokemon(String pokemonIdOrName) async {
    try {
      final response =
          await _dioClient.get(ApiEndpoints.urlDetailPokemon(pokemonIdOrName));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> apiDetailMove(String pokemonIdOrName) async {
    try {
      final response =
          await _dioClient.get(ApiEndpoints.urlDetailMove(pokemonIdOrName));
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

      log("coplete info: $completeInfo");
      return completeInfo;
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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Thêm các phương thức API khác tại đây
}
