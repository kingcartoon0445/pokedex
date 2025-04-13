import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // Gửi sự kiện đăng ký tới BLoC
      // context.read<AuthBloc>().add(
      //       RegisterRequested(
      //         name: _nameController.text.trim(),
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
        title: Text('register_title'.tr()),
      ),
      // body: BlocConsumer<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     if (state is Authenticated) {
      //       // Chuyển hướng đến màn hình chính khi đăng ký thành công
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

      //     return SingleChildScrollView(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Form(
      //         key: _formKey,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: [
      //             // Tiêu đề đăng ký
      //             Text(
      //               'register_welcome'.tr(),
      //               style: Theme.of(context).textTheme.headlineLarge,
      //               textAlign: TextAlign.center,
      //             ),
      //             const SizedBox(height: 32),

      //             // Trường tên
      //             TextFormField(
      //               controller: _nameController,
      //               decoration: InputDecoration(
      //                 labelText: 'form_name'.tr(),
      //                 prefixIcon: const Icon(Icons.person),
      //                 border: const OutlineInputBorder(),
      //               ),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'validation_name_required'.tr();
      //                 }
      //                 return null;
      //               },
      //             ),
      //             const SizedBox(height: 16),

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
      //             const SizedBox(height: 16),

      //             // Trường xác nhận mật khẩu
      //             TextFormField(
      //               controller: _confirmPasswordController,
      //               decoration: InputDecoration(
      //                 labelText: 'form_confirm_password'.tr(),
      //                 prefixIcon: const Icon(Icons.lock_outline),
      //                 border: const OutlineInputBorder(),
      //               ),
      //               obscureText: !_isPasswordVisible,
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'validation_confirm_password_required'.tr();
      //                 }
      //                 if (value != _passwordController.text) {
      //                   return 'validation_password_not_match'.tr();
      //                 }
      //                 return null;
      //               },
      //             ),
      //             const SizedBox(height: 24),

      //             // Nút đăng ký
      //             PrimaryButton(
      //               text: 'register_button'.tr(),
      //               onPressed: _register,
      //             ),
      //             const SizedBox(height: 16),

      //             // Liên kết đến màn hình đăng nhập
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //               child: Text('register_login_prompt'.tr()),
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
