import 'package:libcalculator/src/errors.dart';
import 'package:libcalculator/src/evaluator.dart';
import 'package:libcalculator/src/token.dart';
import 'package:test/test.dart';

void main() {
  late Evaluator evaluator;

  setUp(() {
    evaluator = Evaluator();
  });

  group('Evaluator', () {
    test('evaluates basic addition', () {
      final List<Token> tokens = <Token>[
        Token.number('2'),
        Token.number('3'),
        Token.operator('+'),
      ];
      expect(evaluator.evaluate(tokens), equals(5.0));
    });

    test('evaluates basic subtraction', () {
      final List<Token> tokens = <Token>[
        Token.number('5'),
        Token.number('3'),
        Token.operator('-'),
      ];
      expect(evaluator.evaluate(tokens), equals(2.0));
    });

    test('evaluates basic multiplication', () {
      final List<Token> tokens = <Token>[
        Token.number('4'),
        Token.number('3'),
        Token.operator('*'),
      ];
      expect(evaluator.evaluate(tokens), equals(12.0));
    });

    test('evaluates basic division', () {
      final List<Token> tokens = <Token>[
        Token.number('6'),
        Token.number('2'),
        Token.operator('/'),
      ];
      expect(evaluator.evaluate(tokens), equals(3.0));
    });

    test('throws error on division by zero', () {
      final List<Token> tokens = <Token>[
        Token.number('5'),
        Token.number('0'),
        Token.operator('/'),
      ];
      expect(
        () => evaluator.evaluate(tokens),
        throwsA(
          isA<CalculatorError>().having(
            (final CalculatorError e) => e.message,
            'message',
            'Division by zero',
          ),
        ),
      );
    });

    test('evaluates complex expression', () {
      final List<Token> tokens = <Token>[
        Token.number('3'),
        Token.number('4'),
        Token.number('2'),
        Token.operator('*'),
        Token.operator('+'),
      ];
      expect(evaluator.evaluate(tokens), equals(11.0));
    });
  });
}
