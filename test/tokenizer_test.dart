import 'package:libcalculator/src/errors.dart';
import 'package:libcalculator/src/token.dart';
import 'package:libcalculator/src/tokenizer.dart';
import 'package:test/test.dart';

void main() {
  late Tokenizer tokenizer;

  setUp(() {
    tokenizer = Tokenizer();
  });

  group('Tokenizer', () {
    test('tokenizes single digit numbers', () {
      expect(
        tokenizer.tokenize('5'),
        equals(<Token>[Token.number('5')]),
      );
    });

    test('tokenizes multi-digit numbers', () {
      expect(
        tokenizer.tokenize('1234567890'),
        equals(<Token>[Token.number('1234567890')]),
      );
    });

    test('tokenizes decimal numbers', () {
      expect(
        tokenizer.tokenize('3.14'),
        equals(<Token>[Token.number('3.14')]),
      );
    });

    test('tokenizes operators', () {
      expect(
        tokenizer.tokenize('+'),
        equals(<Token>[Token.operator('+')]),
      );
      expect(
        tokenizer.tokenize('-'),
        equals(<Token>[Token.operator('-')]),
      );
      expect(
        tokenizer.tokenize('*'),
        equals(<Token>[Token.operator('*')]),
      );
      expect(
        tokenizer.tokenize('/'),
        equals(<Token>[Token.operator('/')]),
      );
    });

    test('tokenizes mixed expression', () {
      expect(
        tokenizer.tokenize('12+34.5-56*78/90'),
        equals(<Token>[
          Token.number('12'),
          Token.operator('+'),
          Token.number('34.5'),
          Token.operator('-'),
          Token.number('56'),
          Token.operator('*'),
          Token.number('78'),
          Token.operator('/'),
          Token.number('90'),
        ]),
      );
    });

    test('throws on invalid character', () {
      expect(
        () => tokenizer.tokenize('1x+2'),
        throwsA(isA<CalculatorError>()),
      );
    });

    test('handles empty input', () {
      expect(
        tokenizer.tokenize(''),
        equals(<Token>[]),
      );
    });

    test('handles whitespace correctly', () {
      expect(
        tokenizer.tokenize('1 + 2.5 * 3'),
        equals(<Token>[
          Token.number('1'),
          Token.operator('+'),
          Token.number('2.5'),
          Token.operator('*'),
          Token.number('3'),
        ]),
      );
    });

    test('tokenizes parentheses', () {
      expect(
        tokenizer.tokenize('(1+2)'),
        equals(<Token>[
          Token.leftParen(),
          Token.number('1'),
          Token.operator('+'),
          Token.number('2'),
          Token.rightParen(),
        ]),
      );
    });

    test('tokenizes nested parentheses', () {
      expect(
        tokenizer.tokenize('((1+2)*3)'),
        equals(<Token>[
          Token.leftParen(),
          Token.leftParen(),
          Token.number('1'),
          Token.operator('+'),
          Token.number('2'),
          Token.rightParen(),
          Token.operator('*'),
          Token.number('3'),
          Token.rightParen(),
        ]),
      );
    });
  });
}
