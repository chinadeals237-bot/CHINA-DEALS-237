import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
     flutter build apk --release
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHINA DEALS',
      home: Scaffold(
        appBar: AppBar(title: const Text('CHINA DEALS')),
        body: const Center(child: Text('Bienvenue')),
      ),
    );
  }
}

 