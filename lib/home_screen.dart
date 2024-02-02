import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const path = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              child: const Text("Toggle Theme")),
          const Center(
            child: Text("Home Screen"),
          ),
        ],
      ),
    );
  }
}
