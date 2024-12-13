import 'package:libcalculator/src/token.dart';
import 'package:test/test.dart';

void main() {
  group('Token', () {
    test('numbers are correctly identified', () {
      expect(Token.number('123').isNumber, isTrue);
      expect(Token.number('0.5').isNumber, isTrue);
      expect(Token.operator('+').isNumber, isFalse);
    });

    test('operators are correctly identified', () {
      expect(Token.operator('+').isOperator, isTrue);
      expect(Token.operator('-').isOperator, isTrue);
      expect(Token.operator('*').isOperator, isTrue);
      expect(Token.operator('/').isOperator, isTrue);
      expect(Token.number('123').isOperator, isFalse);
    });

    test('precedence returns correct values', () {
      expect(Token.operator('+').precedence, equals(1));
      expect(Token.operator('-').precedence, equals(1));
      expect(Token.operator('*').precedence, equals(2));
      expect(Token.operator('/').precedence, equals(2));
      expect(Token.operator('123').precedence, equals(0));
    });

    test('value property returns correct string', () {
      expect(Token.number('123').value, equals('123'));
      expect(Token.number('0.5').value, equals('0.5'));
      expect(Token.operator('+').value, equals('+'));
      expect(Token.operator('-').value, equals('-'));
      expect(Token.operator('*').value, equals('*'));
      expect(Token.operator('/').value, equals('/'));
    });

    test('parentheses are correctly identified', () {
      expect(Token.leftParen().isLeftParen, isTrue);
      expect(Token.rightParen().isRightParen, isTrue);
      expect(Token.leftParen().isOperator, isFalse);
      expect(Token.rightParen().isOperator, isFalse);
    });
  });
}
