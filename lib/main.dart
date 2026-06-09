import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import đúng file HomeScreen

void main() {
  runApp(const PharmaApp());
}

class PharmaApp extends StatelessWidget {
  const PharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharma Lookup',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Đảm bảo trỏ đúng vào HomeScreen
      home: const HomeScreen(),
    );
  }
}