import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const BroszinskiPokerApp());
}

class BroszinskiPokerApp extends StatelessWidget {
  const BroszinskiPokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Broszinski Poker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
