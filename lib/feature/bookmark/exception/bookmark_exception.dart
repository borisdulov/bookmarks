class BookmarkException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  BookmarkException(this.message, {this.stackTrace});

  @override
  String toString() => 'BookmarkException: $message';
}

class BookmarkNotFoundException extends BookmarkException {
  BookmarkNotFoundException(super.message);
}

class AlreadyLoadingException extends BookmarkException {
  AlreadyLoadingException(super.message);
}
