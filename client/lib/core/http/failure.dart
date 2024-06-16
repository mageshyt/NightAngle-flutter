class HttpFailure {
  final String message;
  final String? code;

  HttpFailure(
      {this.code, this.message = 'An error occurred. Please try again later.'});

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}
