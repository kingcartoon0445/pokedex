import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  
  @override
  List<Object?> get props => [];
}

// Sự kiện khởi tạo theme
class InitTheme extends ThemeEvent {}

// Sự kiện chuyển đổi theme
class ToggleTheme extends ThemeEvent {}