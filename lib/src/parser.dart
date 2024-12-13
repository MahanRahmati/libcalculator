import 'errors.dart';
import 'token.dart';

/// Converts an infix expression (tokenized) to postfix notation using the
/// Shunting Yard algorithm.
///
/// The parser handles:
/// - Operator precedence
/// - Parentheses grouping
/// - Expression validation
/// - Proper mathematical order of operations
class Parser {
  /// Converts a list of tokens from infix to postfix notation.
  ///
  /// Parameters:
  /// - [tokens]: A list of tokens in infix notation to convert
  ///
  /// Returns:
  /// - A list of tokens in postfix (Reverse Polish) notation
  ///
  /// Throws:
  /// - [CalculatorError] if parentheses are mismatched
  ///
  /// The parsing process:
  /// 1. Processes each token in sequence:
  ///    - Numbers go directly to output
  ///    - Operators are handled based on precedence
  ///    - Left parenthesis are pushed to operator stack
  ///    - Right parenthesis trigger stack unwinding
  /// 2. Remaining operators are added to output
  ///
  /// Example:
  /// ```dart
  /// // For expression "2 + 3", the conversion would be:
  /// // Input (infix): [Token("2"), Token("+"), Token("3")]
  /// // Output (postfix): [Token("2"), Token("3"), Token("+")]
  /// ```
  List<Token> parseToPostfix(final List<Token> tokens) {
    if (tokens.isEmpty) {
      return <Token>[];
    }

    final List<Token> output = <Token>[];
    final List<Token> operatorStack = <Token>[];

    for (final Token token in tokens) {
      if (token.isNumber) {
        output.add(token);
      } else if (token.isLeftParen) {
        operatorStack.add(token);
      } else if (token.isRightParen) {
        while (operatorStack.isNotEmpty && !operatorStack.last.isLeftParen) {
          output.add(operatorStack.removeLast());
        }
        if (operatorStack.isEmpty) {
          throw CalculatorError('Mismatched parentheses');
        }
        // Remove left parenthesis
        operatorStack.removeLast();
      } else if (token.isOperator) {
        while (operatorStack.isNotEmpty &&
            !operatorStack.last.isLeftParen &&
            operatorStack.last.precedence >= token.precedence) {
          output.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      }
    }

    while (operatorStack.isNotEmpty) {
      if (operatorStack.last.isLeftParen) {
        throw CalculatorError('Mismatched parentheses');
      }
      output.add(operatorStack.removeLast());
    }

    return output;
  }
}
