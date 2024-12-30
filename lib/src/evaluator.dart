import 'errors.dart';
import 'token.dart';

/// Evaluates mathematical expressions in postfix notation.
///
/// The evaluator processes tokens in postfix order and:
/// - Performs arithmetic operations
/// - Handles operator precedence
/// - Manages the evaluation stack
/// - Provides error checking for invalid expressions
/// - Prevents division by zero
class Evaluator {
  /// Evaluates a postfix expression and returns the calculated result.
  ///
  /// Parameters:
  /// - [postfix]: A list of tokens in postfix notation to evaluate
  ///
  /// Returns:
  /// - A double representing the calculated result
  ///
  /// Throws:
  /// - [CalculatorError] if the expression is invalid
  /// - [CalculatorError] if division by zero is attempted
  ///
  /// The evaluation process:
  /// 1. Maintains a stack of operands
  /// 2. For each token:
  ///    - If number: pushes to stack
  ///    - If operator: pops two operands and applies operation
  /// 3. Result is the final value on stack
  ///
  /// Example:
  /// ```dart
  /// // For expression "2 + 3", postfix would be [2, 3, +]
  /// evaluate([Token("2"), Token("3"), Token("+")]) // Returns 5.0
  /// ```
  double evaluate(final List<Token> postfix) {
    final List<double> stack = <double>[];

    for (final Token token in postfix) {
      if (token.isNumber) {
        final String normalizedValue = token.value.replaceAll('E', 'e');
        stack.add(double.parse(normalizedValue));
      } else {
        if (stack.length < 2) {
          throw CalculatorError('Invalid expression');
        }
        final double b = stack.removeLast();
        final double a = stack.removeLast();
        stack.add(_executeOperation(a, b, token));
      }
    }

    if (stack.length != 1) {
      throw CalculatorError('Invalid expression');
    }

    return stack.single;
  }

  double _executeOperation(
    final double a,
    final double b,
    final Token operator,
  ) {
    switch (operator.value) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) {
          throw CalculatorError('Division by zero');
        }
        return a / b;
      default:
        throw CalculatorError('Unknown operator: ${operator.value}');
    }
  }
}
