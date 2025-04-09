import 'package:equatable/equatable.dart';
import 'package:pokedex/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Trạng thái ban đầu khi chưa kiểm tra xác thực
class AuthInitial extends AuthState {}

// Trạng thái đang tải
class AuthLoading extends AuthState {}

// Trạng thái đã xác thực với thông tin người dùng
class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// Trạng thái chưa xác thực
class Unauthenticated extends AuthState {}

// Trạng thái xảy ra lỗi
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
