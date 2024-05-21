class ServerException implements Exception {
  String message;
  ServerException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class EmptyException implements Exception {
  String message;
  EmptyException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException implements Exception {
  String message;
  UnauthorizedException({required this.message});
  @override
  String toString() {
    return message;
  }
}
