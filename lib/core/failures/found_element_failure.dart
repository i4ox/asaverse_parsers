final class FoundElementFailure {
  final String error;
  final StackTrace? trace;

  const FoundElementFailure(this.error, {this.trace});
}
