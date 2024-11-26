import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UpdateUserPage extends StatefulWidget {
  final String username; // Add this line

  UpdateUserPage({Key? key, required this.username}) : super(key: key); // Modify this line
  
  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}



class _UpdateUserPageState extends State<UpdateUserPage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;
  String _newUsername = '';
  String _newPassword = '';
  bool _obscurePassword = true;
  Map<String, dynamic> imitasiTabelUser = {};
  String? _selectedUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    String? userData = _prefs.getString('user');
    if (userData != null) {
      imitasiTabelUser = json.decode(userData);
      if (imitasiTabelUser.isNotEmpty) {
        setState(() {
          _selectedUser = imitasiTabelUser.keys.first;
          _newUsername = _selectedUser!;
          _newPassword = imitasiTabelUser[_newUsername];
        });
      }
    }
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedUser != null) {
        imitasiTabelUser.remove(_selectedUser); // Hapus user lama jika diganti
      }
      imitasiTabelUser[_newUsername] = _newPassword;
      String userData = json.encode(imitasiTabelUser);
      await _prefs.setString('user', userData);
      Navigator.pop(context, true);
    }
  }

  void _onUserSelected(String? username) {
    if (username != null && imitasiTabelUser.containsKey(username)) {
      setState(() {
        _selectedUser = username;
        _newUsername = username;
        _newPassword = imitasiTabelUser[username];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User & Password'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedUser,
                      items: imitasiTabelUser.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(key),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select Account',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _onUserSelected,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: _newUsername,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      onSaved: (value) => _newUsername = value!,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: _newPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onSaved: (value) => _newPassword = value!,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _updateUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text('Update'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
