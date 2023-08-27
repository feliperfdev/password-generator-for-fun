import 'dart:math' as math;

extension _StringSplit on String {
  void shuffle() {
    split('').shuffle();
  }
}

class PasswordGenerator {
  final _symbols = '!\$#@%&*()/-_=+\\';
  final _alphabet = 'abcdefghijklmnopqrstuvwxyz';
  final _includable = 'áãàâîçìíúùéèõóò';

  final _numbers = '0123456789';

  String _getRandSymbol() {
    final result = math.Random.secure().nextInt(_symbols.length);
    return _symbols[result];
  }

  String generate(String prevPassword) {
    prevPassword = prevPassword.trim();

    final iterates = (DateTime.now().millisecond / 10).floor();
    var newPassword = '';

    for (int i = 0; i < iterates; i++) {
      if (i <= prevPassword.length - 1) {
        final newRand = _getRandSymbol();
        newPassword += newRand + prevPassword[i];
      }
      if (i <= _alphabet.length - 1) {
        final newRand = _getRandSymbol();
        _alphabet.shuffle();
        newPassword += newRand + _alphabet[i];
      }
      if (i <= _includable.length - 1) {
        final newRand = _getRandSymbol();
        _includable.shuffle();
        newPassword += newRand + _includable[i];
      }
      if (i <= _numbers.length - 1) {
        final newRand = _getRandSymbol();
        _numbers.shuffle();
        newPassword += newRand + _numbers.split('').reversed.toList()[i];
      }
    }

    newPassword.shuffle();
    newPassword = newPassword.split('').reversed.join();

    for (int i = 0; i < iterates; i++) {
      if (i <= prevPassword.length - 1) {
        final newRand = _getRandSymbol();
        newPassword += newRand + prevPassword.split('').reversed.toList()[i];
      }
      if (i <= _alphabet.length - 1) {
        final newRand = _getRandSymbol();
        _alphabet.shuffle();
        newPassword +=
            newRand + _alphabet.toUpperCase().split('').reversed.toList()[i];
      }
      if (i <= _numbers.length - 1) {
        final newRand = _getRandSymbol();
        _numbers.shuffle();
        newPassword += newRand + _numbers.split('').reversed.toList()[i];
      }
      if (i <= _includable.length - 1) {
        final newRand = _getRandSymbol();
        _includable.shuffle();
        newPassword += newRand + _includable.split('').reversed.toList()[i];
      }
    }

    newPassword.shuffle();

    if (newPassword.trim().isEmpty) {
      generate(prevPassword);
    }

    return switch (math.Random().nextInt(2)) {
      0 => newPassword.substring((newPassword.length / 2).floor()),
      1 => newPassword.substring(0, (newPassword.length / 2).floor()),
      int() => newPassword,
    };
  }
}
