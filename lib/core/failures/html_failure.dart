/// Failure which should throw when root element not found
final class HtmlFailure implements Exception {
  /// Message of error
  final String error;

  /// Error stack trace
  final StackTrace? trace;

  const HtmlFailure(this.error, {this.trace});
}
