/// Failure which should throw when parser return empty element
final class EmptyElementFailure implements Exception {
  /// Message of error
  final String error;

  /// Error stack trace
  final StackTrace? trace;

  const EmptyElementFailure(this.error, {this.trace});
}
