import 'package:flutter/material.dart';
import 'package:nilai_ppb_flutter/formulir_nilai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Padding(padding: EdgeInsets.all(7), child: FormulirNilai()),
      ),
    );
  }
}
