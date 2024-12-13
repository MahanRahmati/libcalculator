import 'errors.dart';
import 'token.dart';

/// Converts a string mathematical expression into a list of tokens.
///
/// The tokenizer processes input strings and breaks them down into individual
/// tokens (numbers, operators, and parentheses) while handling:
/// - Multi-digit numbers
/// - Decimal numbers
/// - Basic arithmetic operators
/// - Parentheses
/// - Invalid character detection
class Tokenizer {
  /// Converts a mathematical expression string into a list of tokens.
  ///
  /// Parameters:
  /// - [input]: A string containing the mathematical expression to tokenize
  ///
  /// Returns:
  /// - A list of Token objects representing the expression components
  ///
  /// Throws:
  /// - [CalculatorError] if an invalid character is encountered
  ///
  /// The tokenization process:
  /// 1. Removes all whitespace from input
  /// 2. Processes each character sequentially:
  ///    - Builds multi-digit and decimal numbers
  ///    - Identifies operators (+, -, *, /)
  ///    - Recognizes parentheses
  /// 3. Validates character types
  ///
  /// Example:
  /// ```dart
  /// // Expression "2.5 + 3" becomes:
  /// // [Token("2.5"), Token("+"), Token("3")]
  /// ```
  List<Token> tokenize(final String input) {
    final List<Token> tokens = <Token>[];
    String currentNumber = '';
    final String text = input.replaceAll(' ', '');

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];

      if (_isDigit(char) || char == '.') {
        currentNumber += char;
      } else {
        if (currentNumber.isNotEmpty) {
          tokens.add(Token.number(currentNumber));
          currentNumber = '';
        }

        if (_isOperator(char)) {
          tokens.add(Token.operator(char));
        } else if (char == '(') {
          tokens.add(Token.leftParen());
        } else if (char == ')') {
          tokens.add(Token.rightParen());
        } else {
          throw CalculatorError('Invalid character: $char');
        }
      }
    }

    if (currentNumber.isNotEmpty) {
      tokens.add(Token.number(currentNumber));
    }

    return tokens;
  }

  bool _isDigit(final String char) => '0123456789'.contains(char);
  bool _isOperator(final String char) => '+-*/'.contains(char);
}
