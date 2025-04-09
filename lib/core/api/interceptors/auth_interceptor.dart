import 'package:dio/dio.dart';
import 'package:pokedex/dio/service_locator.dart';
import 'package:pokedex/data/datasources/local/storage_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Lấy token từ bộ nhớ cục bộ và thêm vào header
    final token = getIt<StorageService>().getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Xử lý khi token hết hạn (401 Unauthorized)
    if (err.response?.statusCode == 401) {
      // Xóa token cũ và chuyển hướng về trang đăng nhập
      getIt<StorageService>().removeToken();

      // Tại đây có thể điều hướng người dùng về màn hình đăng nhập
      // Ví dụ: NavigationService.navigateToLogin();
    }

    return super.onError(err, handler);
  }
}
