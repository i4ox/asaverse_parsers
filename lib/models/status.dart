enum Status {
  /// Means title isn't release yet
  ongoing('ONGOING'),

  /// Means title is released
  released('RELEASED'),

  /// Means title is released, but translation of title isn't completed
  continued('CONTINUED'),

  /// Means translation of title is completed
  completed('COMPLETED');

  final String status;
  const Status(this.status);
}
