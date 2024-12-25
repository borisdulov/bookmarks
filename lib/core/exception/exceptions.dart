// sealed class AppException implements Exception {
//   final String message;
//   final StackTrace? stackTrace;

//   const AppException(this.message, [this.stackTrace]);
// }

// class NetworkException extends AppException {
//   final int? statusCode;

//   const NetworkException({
//     required String message,
//     this.statusCode,
//     StackTrace? stackTrace,
//   }) : super(message, stackTrace);
// }

// class AuthException extends AppException {
//   final AuthExceptionType type;

//   const AuthException({
//     required String message,
//     required this.type,
//     StackTrace? stackTrace,
//   }) : super(message, stackTrace);
// }

// enum AuthExceptionType {
//   invalidCredentials,
//   userNotFound,
//   networkError,
//   unknown
// }

// class BookmarkException extends AppException {
//   final BookmarkExceptionType type;

//   const BookmarkException({
//     required String message,
//     required this.type,
//     StackTrace? stackTrace,
//   }) : super(message, stackTrace);
// }

// enum BookmarkExceptionType {
//   duplicateBookmark,
//   bookmarkNotFound,
//   syncError,
//   unknown
// }
