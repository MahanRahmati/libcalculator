/// Represents different types of tokens in a mathematical expression
enum TokenType {
  number,
  operator,
  leftParen,
  rightParen,
}

/// A token class that represents individual elements in a mathematical
/// expression.
///
/// Tokens can be numbers, operators (+, -, *, /), or parentheses.
/// Each token has a type and value, with helper methods for type checking
/// and operator precedence determination.
class Token {
  /// Creates a new Token with the specified type and value.
  ///
  /// Parameters:
  /// - [type]: The TokenType of this token
  /// - [value]: The string value this token represents
  const Token(
    this.type,
    this.value,
  );

  final TokenType type;
  final String value;

  /// Checks if this token represents a number.
  ///
  /// Returns true for numeric values including decimals.
  bool get isNumber => type == TokenType.number;

  /// Checks if this token represents an operator.
  ///
  /// Returns true for +, -, *, and / operators.
  bool get isOperator => type == TokenType.operator;

  /// Checks if this token represents a left parenthesis.
  bool get isLeftParen => type == TokenType.leftParen;

  /// Checks if this token represents a right parenthesis.
  bool get isRightParen => type == TokenType.rightParen;

  /// Gets the precedence level of an operator token.
  ///
  /// Returns:
  /// - 2 for multiplication and division
  /// - 1 for addition and subtraction
  /// - 0 for non-operators
  int get precedence {
    switch (value) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  /// Creates a number token with the given value.
  ///
  /// Parameters:
  /// - [value]: The numeric string to represent
  static Token number(final String value) => Token(TokenType.number, value);

  /// Creates an operator token with the given value.
  ///
  /// Parameters:
  /// - [value]: The operator string (+, -, *, /)
  static Token operator(final String value) => Token(TokenType.operator, value);

  /// Creates a left parenthesis token.
  static Token leftParen() => const Token(TokenType.leftParen, '(');

  /// Creates a right parenthesis token.
  static Token rightParen() => const Token(TokenType.rightParen, ')');

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is Token &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          value == other.value;

  @override
  int get hashCode => type.hashCode ^ value.hashCode;

  @override
  String toString() => 'Token{type: $type, value: $value}';
}
