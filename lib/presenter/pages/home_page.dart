import 'package:flutter/material.dart';
import 'package:password_generator/core/constants.dart';
import 'package:password_generator/presenter/controllers/password_generator_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PasswordGeneratorController controller;

  @override
  void initState() {
    controller = PasswordGeneratorController();

    controller.input.addListener(() {
      setState(() {
        if (controller.input.text.isEmpty) {
          controller.generated = null;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                color: Color.fromARGB(255, 159, 83, 172),
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: controller.input,
              decoration: InputDecoration(
                hintText: 'Base phrase/password',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 159, 83, 172),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 159, 83, 172),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 159, 83, 172),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: controller.input.text.trim().isNotEmpty
                  ? () {
                      setState(() {
                        controller.generate();
                      });
                    }
                  : null,
              child: const Text('Generate'),
            ),
            const SizedBox(height: 30),
            if (controller.generated != null) ...{
              Text(controller.generated!),
              IconButton(
                onPressed: () async {
                  await controller.copyToClipboard();
                  if (!context.mounted) return;
                  controller.showSnackbar(context);
                },
                icon: const Icon(
                  Icons.copy,
                  color: Color.fromARGB(255, 159, 83, 172),
                ),
              ),
            },
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse(AppConstants.myGithub);
                final canLaunch = await canLaunchUrl(uri);
                if (canLaunch) {
                  await launchUrl(uri);
                }
              },
              child: const Text.rich(
                TextSpan(
                  text: 'Developed for studies and fun\n',
                  children: [
                    TextSpan(
                        text: 'By ${AppConstants.myGithubNick}',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 159, 83, 172),
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
