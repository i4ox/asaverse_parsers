final class ParseException implements Exception {
  final String error;
  final StackTrace? trace;

  const ParseException(this.error, {this.trace});
}
