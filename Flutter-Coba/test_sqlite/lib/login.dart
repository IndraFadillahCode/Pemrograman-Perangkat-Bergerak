//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_sqlite/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
//import 'main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 150,
            height: 150,
            child: Image.asset('assets/img/icon.jpg'),
          ),
          Text(
            'Halaman Login',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                      label: Text(
                    'Username',
                    style: TextStyle(fontSize: 14),
                  )),
                  controller: usernameCont,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      label: Text(
                    'Password',
                    style: TextStyle(fontSize: 14),
                  )),
                  controller: passCont,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (usernameCont.text == prefs.getString("nickname") &&
                    passCont.text == prefs.getString("password")) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterScreen();
                }));
              },
              child: Text('Register ?'))
        ],
      )),
    )));
  }
}
