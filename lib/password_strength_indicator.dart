import 'package:flutter/material.dart';
import 'package:password_strength/password_strength_calculator.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final List<Color> colors;
  final PasswordStrengthCalculator calculator;
  final TextStyle? style;

  PasswordStrengthIndicator({
    super.key,
    required this.calculator,
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
    ],
    this.style,
  }) : assert(colors.isNotEmpty, 'Colors must not be empty.');

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: calculator,
      builder: (context, child) {
        final color =
            colors[(calculator.strength.score ~/ (100 / (colors.length - 1)))];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: calculator.strength.score / 100,
              color: color,
            ),
            const SizedBox(height: 8),
            for (final message in calculator.strength.messages)
              Text(
                message,
                style: style ?? Theme.of(context).textTheme.labelMedium,
              )
          ],
        );
      },
    );
  }
}
