
class PasswordCriteria {
  /// The message to display if the criteria is not met.
  final String message;

  /// The test to run to determine if the criteria is met.
  final bool Function(String) _test;

  const PasswordCriteria(this.message, this._test);

  /// The password must be at least [length] characters long to pass.
  PasswordCriteria.length(int length)
      : message = 'Password must be at least $length characters long.',
        _test = ((password) => password.length >= length);

  /// The password must contain at least one uppercase letter to pass.
  PasswordCriteria.uppercase()
      : message = 'Password must contain at least one uppercase letter.',
        _test = ((password) => password.contains(RegExp(r'[A-Z]')));

  /// The password must contain at least one lowercase letter to pass.
  PasswordCriteria.lowercase()
      : message = 'Password must contain at least one lowercase letter.',
        _test = ((password) => password.contains(RegExp(r'[a-z]')));

  /// The password must contain at least one number to pass.
  PasswordCriteria.number()
      : message = 'Password must contain at least one number.',
        _test = ((password) => password.contains(RegExp(r'[0-9]')));

  /// The password must contain at least one special character to pass.
  PasswordCriteria.specialCharacter()
      : message = 'Password must contain at least one special character.',
        _test = ((password) =>
            password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')));

  /// The password must not contain sequential characters to pass.
  PasswordCriteria.sequentialCharacters()
      : message = 'Password must not contain sequential characters.',
        _test = ((password) => RegExp(r'(.+?)\1+').hasMatch(password));

  bool test(String password) => _test(password);
}
