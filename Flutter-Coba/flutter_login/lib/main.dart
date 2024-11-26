import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRegistered = prefs.containsKey('username') && prefs.containsKey('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isRegistered ? LoginScreen() : RegisterScreen();
  }
}
