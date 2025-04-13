import 'package:get_it/get_it.dart';
import 'package:pokedex/core/api/dio_client.dart';
import 'package:pokedex/data/datasources/local/storage_service.dart';
import 'package:pokedex/data/datasources/remote/api_service.dart';
import 'package:pokedex/data/repositories/user_repository.dart';
import 'package:pokedex/presentation/blocs/home/home_bloc.dart';
import 'package:pokedex/presentation/blocs/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:pokedex/presentation/blocs/theme/theme_bloc.dart';
import 'package:pokedex/presentation/blocs/type_detail/type_detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Khởi tạo GetIt singleton
final GetIt getIt = GetIt.instance;

// Thiết lập các dependency
Future<void> setupServiceLocator() async {
  // Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // API Client
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  getIt.registerLazySingleton<StorageService>(
      () => StorageService(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));

  // Repositories
  getIt.registerLazySingleton<PokemonRepository>(() => PokemonRepository(
        apiService: getIt<ApiService>(),
        storageService: getIt<StorageService>(),
      ));

  // BLoCs
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());
  getIt.registerFactory<HomeBloc>(
      () => HomeBloc(pokemonRepository: getIt<PokemonRepository>()));
  getIt.registerFactory<PokemonDetailBloc>(
      () => PokemonDetailBloc(pokemonRepository: getIt<PokemonRepository>()));
  getIt.registerFactory<TypeDetailBloc>(
      () => TypeDetailBloc(pokemonRepository: getIt<PokemonRepository>()));

  // getIt.registerFactory<AuthBloc>(
  //     () => AuthBloc(userRepository: getIt<UserRepository>()));
}
