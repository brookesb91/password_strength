import 'package:flutter_test/flutter_test.dart';

import 'package:password_strength/password_strength.dart';

void main() {
  test('It should calculate a score of 100 for a lowercase password.', () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.lowercase(),
    ]);

    calculator.calculate('password');

    final result = calculator.strength;
    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test('It should calculate a score of 100 for a minimum length of 8.', () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
    ]);

    calculator.calculate('password');

    final result = calculator.strength;
    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test('It should calculate a score of 100 for a password with uppercase.', () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.uppercase(),
    ]);

    calculator.calculate('Password');

    final result = calculator.strength;
    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test('It should calculate a score of 100 for a password with a number.', () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.number(),
    ]);

    calculator.calculate('Password1');

    final result = calculator.strength;
    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test(
      'It should calculate a score of 100 for a password with a special character.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('Password!');

    final result = calculator.strength;
    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test('It should calculate a score of 100 for a password with all criteria.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
      PasswordCriteria.uppercase(),
      PasswordCriteria.lowercase(),
      PasswordCriteria.number(),
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('Password1!');

    final result = calculator.strength;

    expect(result.score, 100, reason: 'The score should be 100.');
    expect(result.messages.length, 0,
        reason: 'No messages should be returned.');
  });

  test('It should calculate a score of 80 for a password with 4 of 5 criteria.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
      PasswordCriteria.uppercase(),
      PasswordCriteria.lowercase(),
      PasswordCriteria.number(),
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('Password1');

    final result = calculator.strength;
    expect(result.score, 80, reason: 'The score should be 80.');
    expect(result.messages.length, 1,
        reason: 'One message should be returned.');
  });

  test('It should calculate a score of 60 for a password with 3 of 5 criteria.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
      PasswordCriteria.uppercase(),
      PasswordCriteria.lowercase(),
      PasswordCriteria.number(),
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('Password');

    final result = calculator.strength;
    expect(result.score, 60, reason: 'The score should be 60.');
    expect(result.messages.length, 2,
        reason: 'Two messages should be returned.');
  });

  test('It should calculate a score of 40 for a password with 2 of 5 criteria.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
      PasswordCriteria.uppercase(),
      PasswordCriteria.lowercase(),
      PasswordCriteria.number(),
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('password');

    final result = calculator.strength;
    expect(result.score, 40, reason: 'The score should be 40.');
    expect(result.messages.length, 3,
        reason: 'Three messages should be returned.');
  });

  test('It should calculate a score of 20 for a password with 1 of 5 criteria.',
      () {
    final calculator = PasswordStrengthCalculator([
      PasswordCriteria.length(8),
      PasswordCriteria.uppercase(),
      PasswordCriteria.lowercase(),
      PasswordCriteria.number(),
      PasswordCriteria.specialCharacter(),
    ]);

    calculator.calculate('shorty');

    final result = calculator.strength;
    expect(result.score, 20, reason: 'The score should be 20.');
    expect(result.messages.length, 4,
        reason: 'Four messages should be returned.');
  });
}
