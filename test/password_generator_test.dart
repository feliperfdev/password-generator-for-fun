import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:password_generator/core/password_generator.dart';

void main() {
  test('Testa se todas as senhas de uma mesma frase serão diferentes', () {
    final generator = PasswordGenerator();
    List<String> generatedPassword = [];
    for (int i = 0; i < 1000; i++) {
      final generated = generator.generate('flutterisnotdead');
      generatedPassword.add(generated);
    }
    final prevLength = generatedPassword.length;
    final newLength = generatedPassword
        .toSet() //.toSet() removes all repeated elements
        .length;

    expect(prevLength == newLength, isTrue);
  });

  test('Testa se não serão geradas senhas vazias', () {
    final generator = PasswordGenerator();
    List<String> generatedPassword = [];
    for (int i = 0; i < 1000; i++) {
      final generated = generator.generate('flutterisnotdead');
      generatedPassword.add(generated);
    }

    expect(generatedPassword.any((p) => p == ''), isFalse);
    Timer(const Duration(milliseconds: 500), () {});
  });

  test('Testa se não serão geradas senhas exatamente iguais à `base password`',
      () async {
    final generator = PasswordGenerator();
    List<String> generatedPassword = [];
    for (int i = 0; i < 1000; i++) {
      final generated = generator.generate('flutterisnotdead');
      generatedPassword.add(generated);
    }

    expect(generatedPassword.any((p) => p == 'flutterisnotdead'), isFalse);
    Timer(const Duration(milliseconds: 500), () {});
  });

  test('Testa se a nova senha gerada irá conter números', () {
    late String generated;
    final generator = PasswordGenerator();
    generated = generator.generate('flutterisnotdead');

    final numbers =
        <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((e) => e.toString()).toList();

    expect(
        generated
            .split('')
            .toList()
            .any((p) => numbers.any((element) => element == p)),
        isTrue);
  });
}
