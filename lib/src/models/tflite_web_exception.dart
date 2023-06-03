/// Exception related to TFLiteWeb package
class TFLiteWebException implements Exception {
  /// Exception related to TFLiteWeb package
  TFLiteWebException(this.message);

  /// Exception message
  final dynamic message;

  @override
  String toString() {
    final message = this.message;
    if (message == null) {
      return 'TFLiteWebException';
    }

    return 'TFLiteWebException : $message';
  }
}
