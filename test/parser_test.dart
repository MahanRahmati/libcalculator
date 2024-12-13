import 'package:libcalculator/src/errors.dart';
import 'package:libcalculator/src/parser.dart';
import 'package:libcalculator/src/token.dart';
import 'package:test/test.dart';

void main() {
  late Parser parser;

  setUp(() {
    parser = Parser();
  });

  group('Parser', () {
    test('converts simple addition to postfix', () {
      final List<Token> tokens = <Token>[
        Token.number('1'),
        Token.operator('+'),
        Token.number('2'),
      ];
      final List<Token> result = parser.parseToPostfix(tokens);
      expect(
        result.map((final Token t) => t.value).toList(),
        <String>['1', '2', '+'],
      );
    });

    test('handles operator precedence correctly', () {
      final List<Token> tokens = <Token>[
        Token.number('1'),
        Token.operator('+'),
        Token.number('2'),
        Token.operator('*'),
        Token.number('3'),
      ];
      final List<Token> result = parser.parseToPostfix(tokens);
      expect(
        result.map((final Token t) => t.value).toList(),
        <String>['1', '2', '3', '*', '+'],
      );
    });

    test('processes multiple operators with same precedence', () {
      final List<Token> tokens = <Token>[
        Token.number('1'),
        Token.operator('+'),
        Token.number('2'),
        Token.operator('-'),
        Token.number('3'),
      ];
      final List<Token> result = parser.parseToPostfix(tokens);
      expect(
        result.map((final Token t) => t.value).toList(),
        <String>['1', '2', '+', '3', '-'],
      );
    });

    test('handles empty token list', () {
      final List<Token> result = parser.parseToPostfix(<Token>[]);
      expect(result, isEmpty);
    });

    test('handles simple parentheses', () {
      final List<Token> tokens = <Token>[
        Token.leftParen(),
        Token.number('2'),
        Token.operator('+'),
        Token.number('3'),
        Token.rightParen(),
      ];
      final List<Token> result = parser.parseToPostfix(tokens);
      expect(
        result.map((final Token t) => t.value).toList(),
        <String>['2', '3', '+'],
      );
    });

    test('handles nested parentheses', () {
      final List<Token> tokens = <Token>[
        Token.leftParen(),
        Token.number('1'),
        Token.operator('+'),
        Token.leftParen(),
        Token.number('2'),
        Token.operator('*'),
        Token.number('3'),
        Token.rightParen(),
        Token.rightParen(),
      ];
      final List<Token> result = parser.parseToPostfix(tokens);
      expect(
        result.map((final Token t) => t.value).toList(),
        <String>['1', '2', '3', '*', '+'],
      );
    });

    test('throws on mismatched parentheses', () {
      final List<Token> tokens = <Token>[
        Token.leftParen(),
        Token.number('2'),
        Token.operator('+'),
        Token.number('3'),
      ];
      expect(
        () => parser.parseToPostfix(tokens),
        throwsA(isA<CalculatorError>()),
      );
    });
  });
}
