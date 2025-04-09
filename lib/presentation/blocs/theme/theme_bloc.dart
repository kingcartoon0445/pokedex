import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/dio/service_locator.dart';
import 'package:pokedex/data/datasources/local/storage_service.dart';
import 'package:pokedex/presentation/blocs/theme/theme_event.dart';
import 'package:pokedex/presentation/blocs/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService _storageService = getIt<StorageService>();

  ThemeBloc()
      : super(
          ThemeState(
            themeMode: ThemeMode.light,
            themeData: _lightTheme,
          ),
        ) {
    on<InitTheme>(_onInitTheme);
    on<ToggleTheme>(_onToggleTheme);

    // Khởi tạo theme
    add(InitTheme());
  }

  // Xử lý sự kiện khởi tạo theme
  void _onInitTheme(InitTheme event, Emitter<ThemeState> emit) {
    final isDarkMode = _storageService.isDarkMode();

    emit(
      ThemeState(
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        themeData: isDarkMode ? _darkTheme : _lightTheme,
      ),
    );
  }

  // Xử lý sự kiện chuyển đổi theme
  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    final isDarkMode = state.themeMode == ThemeMode.dark;
    final newIsDarkMode = !isDarkMode;

    // Lưu trạng thái theme mới
    await _storageService.setDarkMode(newIsDarkMode);

    emit(
      ThemeState(
        themeMode: newIsDarkMode ? ThemeMode.dark : ThemeMode.light,
        themeData: newIsDarkMode ? _darkTheme : _lightTheme,
      ),
    );
  }

  // Định nghĩa theme sáng
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black87),
      headlineMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  // Định nghĩa theme tối
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[800],
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}
