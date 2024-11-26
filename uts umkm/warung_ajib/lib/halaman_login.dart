import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class HalamanLogin extends StatefulWidget {
  final SharedPreferences spInstance;
  const HalamanLogin(this.spInstance, {super.key});
  @override
  State<StatefulWidget> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool showPassword = false;
  Map<String, dynamic> imitasiTabelUser = {};

  @override
  void initState() {
    super.initState();
    String? imitasiTabelUserSp = widget.spInstance.getString("user");
    imitasiTabelUser =
        imitasiTabelUserSp == null ? {} : json.decode(imitasiTabelUserSp);
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(7),
      child: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Kembali",
                          style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: Theme.of(context).colorScheme.primary),
                        )
                      ]),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          label: Text("Username"),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.key),
                          label: const Text("Password"),
                          suffixIcon: GestureDetector(
                            onTap: toggleShowPassword,
                            child: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(height: 14),
                    Row(children: [
                      Expanded(
                        child: FilledButton.icon(
                            onPressed: () {
                              if (imitasiTabelUser[usernameController.text] !=
                                  passwordController.text) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    "Username atau password salah",
                                  ),
                                  action: SnackBarAction(
                                      label: "Tutup",
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                      }),
                                ));
                                return;
                              }

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HalamanDashboard()),
                                  (route) => false);
                            },
                            icon: const Icon(Icons.login),
                            label: const Text("Login")),
                      )
                    ]),
                  ]))),
    ));
  }
}
