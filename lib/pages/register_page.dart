import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { male, female }

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  final _city = TextEditingController();

  bool _isActionFavorite = false;
  bool _isFantasyFavorite = false;
  bool _isLoveFavorite = false;
  bool _isTerrorFavorite = false;

  bool _passwordVisible = true;
  bool _repPasswordVisible = true;

  String _birthDate = "Fecha de Nacimiento";

  Genre? _genre = Genre.male;
  String _genreSelected = 'Masculino';

  final List<String> _cities = [
    'Barranquilla',
    'Bogotá',
    'Cali',
    'Medellín',
    'Pereira',
  ];

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _showSelectDate() async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale("es", "CO"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1924, 01, 01),
        lastDate: DateTime.now(),
        helpText: _birthDate);
    if (newDate != null) {
      setState(() {
        _birthDate = "Fecha de nacimiento ${_dateConverter(newDate)}";
      });
    }
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
                  height: 16.0,
                ),
                TextFormField(
                  controller: _repPassword,
                  obscureText: _repPasswordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Repita la contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(_repPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _repPasswordVisible = !_repPasswordVisible;
                          });
                        }),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DropdownMenu<String>(
                  width: 330,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  label: const Text("Ciudad"),
                  onSelected: (String? city) {
                    setState(() {
                      _city.text = city!;
                    });
                  },
                  dropdownMenuEntries:
                  _cities.map<DropdownMenuEntry<String>>((String city) {
                    return DropdownMenuEntry<String>(value: city, label: city);
                  }).toList(),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Seleccione su género",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Masculino'),
                          value: Genre.male,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                              _genreSelected = 'Masculino';
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Femenino'),
                          value: Genre.female,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                              _genreSelected = 'Femenino';
                            });
                          }),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: Text(_birthDate),
                  onPressed: () {
                    _showSelectDate();
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Géneros literarios favoritos",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                          title: const Text("Acción"),
                          value: _isActionFavorite,
                          selected: _isActionFavorite,
                          onChanged: (bool? value) {
                            setState(() {
                              _isActionFavorite = value!;
                            });
                          }),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                          title: const Text("Fantasía"),
                          value: _isFantasyFavorite,
                          selected: _isFantasyFavorite,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFantasyFavorite = value!;
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                          title: const Text("Amor"),
                          value: _isLoveFavorite,
                          selected: _isLoveFavorite,
                          onChanged: (bool? value) {
                            setState(() {
                              _isLoveFavorite = value!;
                            });
                          }),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                          title: const Text("Terror"),
                          value: _isTerrorFavorite,
                          selected: _isTerrorFavorite,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTerrorFavorite = value!;
                            });
                          }),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: _onRegisterButtonClicked,
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        var user = User(_name.text, _email.text, _password.text);
        _saveUser(user);
        Navigator.pop(context);
      } else {
        print("error");
      }
    });
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }
}

//Marzo 21 de 2024
