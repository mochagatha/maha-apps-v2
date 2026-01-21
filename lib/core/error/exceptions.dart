// Core error handling - Exceptions
// Exceptions are thrown in the data layer and caught in repositories

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

class CompanyCodeNotVerifiedException implements Exception {
  final String message;
  CompanyCodeNotVerifiedException([this.message = 'Akun belum terverifikasi']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
