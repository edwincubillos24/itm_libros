import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itm_libros/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../repository/firebase_api.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _passwordVisible = true;

  User userLoaded = User.Empty();

  void _onLoginButtonClicked() {
    _firebaseApi.loginUser(_email.text, _password.text);
   /* if (_email.text == userLoaded.email &&
        _password.text == userLoaded.password) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    else {
      print("Error");
    }*/
  }

  void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoaded = User.fromJson(userMap);
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _password,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: _onLoginButtonClicked,
                  child: const Text("Iniciar sesión"),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Regístrese'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
