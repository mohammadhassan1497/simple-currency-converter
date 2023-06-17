class ServerException implements Exception {
  final String message;

  ServerException({this.message = 'Something went wrong'});

  @override
  String toString() => message;
}

class HTTPException implements Exception {
  final String message;
  final int statusCode;

  HTTPException({required this.message, required this.statusCode});

  @override
  String toString() => message;
}
