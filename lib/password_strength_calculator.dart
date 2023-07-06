import 'package:flutter/foundation.dart';
import 'package:password_strength/password_criteria.dart';
import 'package:password_strength/password_strength_result.dart';

class PasswordStrengthCalculator extends ChangeNotifier {
  PasswordStrengthResult _strength = const PasswordStrengthResult(score: 0);
  PasswordStrengthResult get strength => _strength;

  /// The [criteria] to use when calculating the password strength.
  final List<PasswordCriteria> _criteria;

  /// A [validator] that can be used with a [TextFormField] that uses
  /// the password criteria and returns the message of the first criteria
  /// that failed.
  String? Function(String?)? get validator => (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required.';
        }

        for (final criteria in _criteria) {
          if (!criteria.test(value)) {
            return criteria.message;
          }
        }

        return null;
      };

  PasswordStrengthCalculator(this._criteria)
      : assert(_criteria.isNotEmpty, 'At least one criteria must be provided.');

  /// Calculates the strength of the [password].
  void calculate(String password) {
    final messages = _criteria
        .where((criteria) => !criteria.test(password))
        .map((criteria) => criteria.message)
        .toList();

    final int passes = _criteria.length - messages.length;

    _strength = PasswordStrengthResult(
      score: _criteria.isEmpty ? 0 : passes / _criteria.length * 100,
      messages: messages,
    );

    notifyListeners();
  }
}
