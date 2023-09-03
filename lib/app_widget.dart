import 'package:flutter/material.dart';
import 'package:password_generator/core/constants.dart';
import 'package:password_generator/presenter/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 159, 83, 172),
        ),
      ),
      initialRoute: AppConstants.initialRoute,
      routes: {
        AppConstants.initialRoute: (context) => const HomePage(),
      },
    );
  }
}
