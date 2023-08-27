import 'package:flutter_test/flutter_test.dart';
import 'package:password_generator/core/password_generator.dart';

void main() {
  test('Testa se gera uma nova senha', () {
    final generator = PasswordGenerator();
    final generated = generator.generate('flutterisbetterthenreactnative');
    expect(generated, isNotEmpty);
  });

  test('Testa se todas as senhas de uma mesma frase serão diferentes', () {
    final generator = PasswordGenerator();
    List<String> generatedPassword = [];
    for (int i = 0; i < 200; i++) {
      final generated = generator.generate('flutterisbetterthenreactnative');
      generatedPassword.add(generated);
    }
    final prevLength = generatedPassword.length;
    final newLength = generatedPassword
        .toSet() //.toSet() removes all repeated elements
        .length;

    expect(prevLength == newLength, isTrue);
  });
}
