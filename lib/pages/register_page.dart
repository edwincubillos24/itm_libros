import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
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
              controller: _name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person)),
              keyboardType: TextInputType.text,
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
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility)),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _repPassword,
              obscureText: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Repita la contraseña',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off)),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: _onRegisterButtonClicked,
              child: const Text("Registrar"),
            ),
          ],
        )),
      ),
    );
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text){
        var user = User(_name.text, _email.text, _password.text);
        _saveUser(user);
      } else {
        //mostramos un mensaje de error
      }
    });
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }
}
