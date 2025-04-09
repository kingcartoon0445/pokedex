import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object?> get props => [];
}

// Sự kiện kiểm tra trạng thái xác thực
class CheckAuthStatus extends AuthEvent {}

// Sự kiện yêu cầu đăng nhập
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  const LoginRequested({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}

// Sự kiện yêu cầu đăng ký
class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  
  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [name, email, password];
}

// Sự kiện yêu cầu đăng xuất
class LogoutRequested extends AuthEvent {}