import 'package:flutter/material.dart';
import 'package:flutter_estehajib/splash_screen.dart';
void main() {
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
// This widget is the root of your application.
@override

Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Aplikasi Es Teh Ajib',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: const SplashScreen(),
);
}
}