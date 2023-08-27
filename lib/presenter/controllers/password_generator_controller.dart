import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/core/password_generator.dart';

class PasswordGeneratorController {
  String? generated;

  final input = TextEditingController();

  void generate() {
    final generator = PasswordGenerator();
    generated = generator.generate(input.text);
  }

  Future<void> copyToClipboard() async {
    await Clipboard.setData(
      ClipboardData(
        text: generated!,
      ),
    );
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        backgroundColor: Colors.green,
        content: Text(
          'Senha copiada para área de transferência com sucesso!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
