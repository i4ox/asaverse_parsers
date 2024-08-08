final class ParseFailure implements Exception {
  final String error;
  final StackTrace? trace;

  const ParseFailure(this.error, {this.trace});
}
