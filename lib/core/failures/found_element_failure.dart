/// Failure which should throw when parser can't return the element
final class FoundElementFailure implements Exception {
  /// Message of error
  final String error;

  /// Error stack trace
  final StackTrace? trace;

  const FoundElementFailure(this.error, {this.trace});
}
