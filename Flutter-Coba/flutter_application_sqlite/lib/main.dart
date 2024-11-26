import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/list_kontak.dart';
void main() {
runApp(const MainApp());
}
class MainApp extends StatelessWidget {
const MainApp({super.key});
@override
Widget build(BuildContext context) {
return const MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Flutter Demo',
home: ListKontakPage(),
);
}
}