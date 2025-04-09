import 'package:flutter/material.dart';
import 'package:pokedex/presentation/screens/auth/login_screen.dart';
import 'package:pokedex/presentation/screens/auth/register_screen.dart';
import 'package:pokedex/presentation/screens/home/home_screen.dart';

class AppRoutes {
  // Định nghĩa các route name
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // Đăng ký các route
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        home: (context) => const HomeScreen(),
      };
}

// Sử dụng PageRouteBuilder để tùy chỉnh animation
Route CreateRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
