// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pokedex/data/models/user_model.dart';
// import 'package:pokedex/data/repositories/user_repository.dart';
// import 'package:pokedex/presentation/blocs/auth/auth_event.dart';
// import 'package:pokedex/presentation/blocs/auth/auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final UserRepository userRepository;

//   AuthBloc({required this.userRepository}) : super(AuthInitial()) {
//     on<CheckAuthStatus>(_onCheckAuthStatus);
//     on<LoginRequested>(_onLoginRequested);
//     on<RegisterRequested>(_onRegisterRequested);
//     on<LogoutRequested>(_onLogoutRequested);
//   }

//   // Xử lý sự kiện kiểm tra trạng thái xác thực
//   Future<void> _onCheckAuthStatus(
//     CheckAuthStatus event,
//     Emitter<AuthState> emit,
//   ) async {
//     // Kiểm tra nếu đã đăng nhập
//     final isLoggedIn = userRepository.isLoggedIn();

//     if (isLoggedIn) {
//       try {
//         // Lấy thông tin người dùng từ API
//         final user = await userRepository.getUserProfile();
//         emit(Authenticated(user: user));
//       } catch (e) {
//         // Nếu có lỗi, đăng xuất và chuyển về trạng thái chưa xác thực
//         await userRepository.logout();
//         emit(Unauthenticated());
//       }
//     } else {
//       emit(Unauthenticated());
//     }
//   }

//   // Xử lý sự kiện đăng nhập
//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     try {
//       final user = await userRepository.login(
//         event.email,
//         event.password,
//       );
//       emit(Authenticated(user: user));
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }

//   // Xử lý sự kiện đăng ký
//   Future<void> _onRegisterRequested(
//     RegisterRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     try {
//       final user = await userRepository.register(
//         event.name,
//         event.email,
//         event.password,
//       );
//       emit(Authenticated(user: user));
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }

//   // Xử lý sự kiện đăng xuất
//   Future<void> _onLogoutRequested(
//     LogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     try {
//       await userRepository.logout();
//       emit(Unauthenticated());
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }
// }
