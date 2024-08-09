/// Failure which should throw when parser can't parse the response
final class ParseFailure implements Exception {
  /// Message of error
  final String error;

  /// Error stack trace
  final StackTrace? trace;

  const ParseFailure(this.error, {this.trace});
}
