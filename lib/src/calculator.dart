import 'package:libcalculator/src/token.dart';

import 'evaluator.dart';
import 'parser.dart';
import 'tokenizer.dart';

/// Main calculator class that coordinates the expression evaluation process.
///
/// The calculator:
/// - Processes input strings
/// - Coordinates tokenization, parsing, and evaluation
/// - Handles result formatting
/// - Provides error handling
/// - Rounds results to 10 decimal places
/// - Returns integers for whole number results
class Calculator {
  final Tokenizer _tokenizer = Tokenizer();
  final Parser _parser = Parser();
  final Evaluator _evaluator = Evaluator();

  /// Evaluates a mathematical expression string and returns the result.
  ///
  /// Parameters:
  /// - [input]: A string containing the mathematical expression to evaluate
  ///
  /// Returns:
  /// - A string representing the calculated result
  /// - Empty string if input is empty
  /// - Error message string if calculation fails
  ///
  /// The calculation process:
  /// 1. Removes all whitespace from the input
  /// 2. Tokenizes the expression into individual components
  /// 3. Converts to postfix notation
  /// 4. Evaluates the expression
  /// 5. Rounds to 10 decimal places
  /// 6. Returns integer if result is a whole number
  ///
  /// Example:
  /// ```dart
  /// calculator.calculate("2 + 2") // Returns "4"
  /// calculator.calculate("2.5 * 3") // Returns "7.5"
  /// calculator.calculate("") // Returns ""
  /// calculator.calculate("1/0") // Returns "Error: Division by zero"
  /// ```
  String calculate(final String input) {
    String text = input.replaceAll(' ', '');
    if (text.isEmpty) {
      return '';
    }

    try {
      if (text.startsWith('-')) {
        text = '0$text';
      }
      final List<Token> tokens = _tokenizer.tokenize(text);
      final List<Token> postfix = _parser.parseToPostfix(tokens);
      final double result = _evaluator.evaluate(postfix);
      final double roundedResult = double.parse(result.toStringAsFixed(10));
      return roundedResult % 1 == 0
          ? roundedResult.toInt().toString()
          : roundedResult.toString();
    } catch (e) {
      return 'Error: $e';
    }
  }
}
