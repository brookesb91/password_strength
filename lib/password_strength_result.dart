class PasswordStrengthResult {
  /// The score of the password.
  final double score;

  /// The messages of criteria that were not met.
  final List<String> messages;

  const PasswordStrengthResult({this.score = 0, this.messages = const []});

  PasswordStrengthResult copyWith({double? score, List<String>? messages}) =>
      PasswordStrengthResult(
        score: score ?? this.score,
        messages: messages ?? this.messages,
      );
}
