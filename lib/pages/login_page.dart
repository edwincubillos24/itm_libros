import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itm_libros/pages/home_page_navigation_bar_page.dart';
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

  void _showMsg(String msg){
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _onLoginButtonClicked() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg("Debe digitar correo electrónico y contraseña");
    } else if (!_email.text.isValidEmail()) {
      _showMsg("El correo electrónico es inválido");
    } else {
      final result = await _firebaseApi.loginUser(_email.text, _password.text);
      print("Resultado $result");
      if (result == "network-request-failed") {
        _showMsg("Revise su conexión a internet");
      } else if (result == "invalid-credential") {
        _showMsg("Correo electrónico o contraseña incorrectas");
      } else {
        _showMsg("Bienvenido");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePageNavigationBarPage()));
      }
    }
  }

/*  void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoaded = User.fromJson(userMap);
  }
*/
  @override
  void initState() {
//    _getUser();
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                  value!.isValidEmail() ? null : 'Correo invalido',
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

extension on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
