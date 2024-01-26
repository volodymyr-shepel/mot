import 'package:mot/constants.dart';
import 'package:test/test.dart';

//flutter test lib/test/unit/test_regular_expression.dart
void main() {
  group('Email Validator', () {
    test('Valid email', () {
      expect(emailValidatorRegExp.hasMatch('test@example.com'), isTrue);
      expect(emailValidatorRegExp.hasMatch('john.doe123@example.co.uk'), isTrue);
    });

    test('Invalid email', () {
      expect(emailValidatorRegExp.hasMatch('invalid-email'), isFalse);
      expect(emailValidatorRegExp.hasMatch('user@com'), isFalse);
    });

    test('Email with special characters in local part', () {
      expect(emailValidatorRegExp.hasMatch('user&name@example.com'), isFalse);
      expect(emailValidatorRegExp.hasMatch('user+name@example.com'), isFalse);
    });

    test('Email with subdomains', () {
      expect(emailValidatorRegExp.hasMatch('user@sub.example.com'), isTrue);
      expect(emailValidatorRegExp.hasMatch('user@sub.sub.example.com'), isTrue);
    });

    test('Email with hyphens in domain', () {
      expect(emailValidatorRegExp.hasMatch('user@my-domain.com'), isFalse);
      expect(emailValidatorRegExp.hasMatch('user@sub-domain.example.com'), isFalse);
    });

    test('Email with multiple dots in domain', () {
      expect(emailValidatorRegExp.hasMatch('user@my..domain.com'), isFalse);
      expect(emailValidatorRegExp.hasMatch('user@sub..example.com'), isFalse);
    });

  });

  group('Password Validator', () {
    test('Valid password', () {
      expect(passwordValidatorRegExp.hasMatch('StrongPassword123!'), isTrue);
      expect(passwordValidatorRegExp.hasMatch('AnotherStrongPassword!123'), isTrue);
    });

    test('Invalid password', () {
      expect(passwordValidatorRegExp.hasMatch('weakpassword'), isFalse);
      expect(passwordValidatorRegExp.hasMatch('noSpecialChars123'), isFalse);
      expect(passwordValidatorRegExp.hasMatch('Short!1'), isFalse);
    });

    test('Valid password - minimum length', () {
      expect(passwordValidatorRegExp.hasMatch('Abc!12345678'), isTrue);
    });

    test('Invalid password - no uppercase letter', () {
      expect(passwordValidatorRegExp.hasMatch('abc!1234567890'), isFalse);
    });

    test('Invalid password - no lowercase letter', () {
      expect(passwordValidatorRegExp.hasMatch('ABC!1234567890'), isFalse);
    });

    test('Invalid password - no special character', () {
      expect(passwordValidatorRegExp.hasMatch('Abcdefghijk1234567890'), isFalse);
    });

    test('Valid password - all criteria met', () {
      expect(passwordValidatorRegExp.hasMatch('Abc!1234567890'), isTrue);
    });
  });
}
