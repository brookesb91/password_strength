import 'package:password_strength/criteria.dart';
import 'package:password_strength/password_strength_result.dart';

class PasswordStrengthCalculator {
  final List<PasswordCriteria> _criteria;

  /// The [criteria] to use when calculating the password strength.
  const PasswordStrengthCalculator(this._criteria)
      : assert(_criteria.length > 0, 'At least one criteria must be provided.');

  /// Calculates the strength of the [password].
  ///
  /// Returns a [PasswordStrengthResult] object containing the score and messages.
  PasswordStrengthResult calculate(String password) {
    final messages = _criteria
        .where((criteria) => !criteria.test(password))
        .map((criteria) => criteria.message)
        .toList();

    final int passes = _criteria.length - messages.length;

    return PasswordStrengthResult(
      score: _criteria.isEmpty ? 0 : passes / _criteria.length * 100,
      messages: messages,
    );
  }
}
