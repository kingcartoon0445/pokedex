import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/config/routes.dart';
import 'package:pokedex/presentation/blocs/auth/auth_event.dart';
import 'package:pokedex/presentation/blocs/auth/auth_state.dart';
import 'package:pokedex/presentation/widget/buttons/primary_button.dart';
import 'package:pokedex/presentation/widget/loading_indicator.dart';

import '../../blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // Gửi sự kiện đăng nhập tới BLoC
      // context.read<AuthBloc>().add(
      //       LoginRequested(
      //         email: _emailController.text.trim(),
      //         password: _passwordController.text.trim(),
      //       ),
      //     );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login_title'.tr()),
      ),
      // body: BlocConsumer<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     if (state is Authenticated) {
      //       // Chuyển hướng đến màn hình chính khi đăng nhập thành công
      //       Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      //     } else if (state is AuthError) {
      //       // Hiển thị thông báo lỗi
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text(state.message)),
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is AuthLoading) {
      //       return const Center(child: LoadingIndicator());
      //     }

      //     return Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Form(
      //         key: _formKey,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: [
      //             // Tiêu đề đăng nhập
      //             Text(
      //               'login_welcome'.tr(),
      //               style: Theme.of(context).textTheme.headlineLarge,
      //               textAlign: TextAlign.center,
      //             ),
      //             const SizedBox(height: 32),

      //             // Trường email
      //             TextFormField(
      //               controller: _emailController,
      //               decoration: InputDecoration(
      //                 labelText: 'form_email'.tr(),
      //                 prefixIcon: const Icon(Icons.email),
      //                 border: const OutlineInputBorder(),
      //               ),
      //               keyboardType: TextInputType.emailAddress,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'validation_email_required'.tr();
      //                 }
      //                 if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
      //                     .hasMatch(value)) {
      //                   return 'validation_email_invalid'.tr();
      //                 }
      //                 return null;
      //               },
      //             ),
      //             const SizedBox(height: 16),

      //             // Trường mật khẩu
      //             TextFormField(
      //               controller: _passwordController,
      //               decoration: InputDecoration(
      //                 labelText: 'form_password'.tr(),
      //                 prefixIcon: const Icon(Icons.lock),
      //                 suffixIcon: IconButton(
      //                   icon: Icon(
      //                     _isPasswordVisible
      //                         ? Icons.visibility
      //                         : Icons.visibility_off,
      //                   ),
      //                   onPressed: _togglePasswordVisibility,
      //                 ),
      //                 border: const OutlineInputBorder(),
      //               ),
      //               obscureText: !_isPasswordVisible,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'validation_password_required'.tr();
      //                 }
      //                 if (value.length < 6) {
      //                   return 'validation_password_length'.tr();
      //                 }
      //                 return null;
      //               },
      //             ),
      //             const SizedBox(height: 24),

      //             // Nút đăng nhập
      //             PrimaryButton(
      //               text: 'login_button'.tr(),
      //               onPressed: _login,
      //             ),
      //             const SizedBox(height: 16),

      //             // Liên kết đến màn hình đăng ký
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.of(context).pushNamed(AppRoutes.register);
      //               },
      //               child: Text('login_register_prompt'.tr()),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
