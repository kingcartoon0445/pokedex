// Định nghĩa các exception trong ứng dụng

// Exception cho lỗi server
class ServerException implements Exception {
  final String message;
  final int statusCode;
  
  ServerException({
    required this.message,
    required this.statusCode,
  });
  
  @override
  String toString() => 'ServerException: $message (Status Code: $statusCode)';
}

// Exception cho lỗi cache
class CacheException implements Exception {
  final String message;
  
  CacheException({required this.message});
  
  @override
  String toString() => 'CacheException: $message';
}

// Exception cho lỗi kết nối
class NetworkException implements Exception {
  final String message;
  
  NetworkException({required this.message});
  
  @override
  String toString() => 'NetworkException: $message';
}

// Exception cho lỗi xác thực
class AuthException implements Exception {
  final String message;
  
  AuthException({required this.message});
  
  @override
  String toString() => 'AuthException: $message';
}