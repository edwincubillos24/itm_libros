import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../repository/firebase_api.dart';
import '../utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { male, female }

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  final _city = TextEditingController();

  bool _isActionFavorite = false,
      _isAdventureFavorite = false,
      _isDramaFavorite = false;
  bool _isFantasyFavorite = false,
      _isFictionFavorite = false,
      _isRomanceFavorite = false;
  bool _isSuspenseFavorite = false, _isTerrorFavorite = false;

  bool _passwordVisible = true;
  bool _repPasswordVisible = true;

  String _birthDate = "";
  String _birthDateLabel = "Fecha de Nacimiento";

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
        helpText: _birthDateLabel);
    if (newDate != null) {
      setState(() {
        _birthDate = _dateConverter(newDate);
      });
    }
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      prefixIcon: Icon(Icons.email),
                      helperText: '*Campo obligatorio'),
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
                      helperText: '*Campo obligatorio'),
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
                      helperText: '*Campo obligatorio'),
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
                  child: Text("$_birthDateLabel: $_birthDate"),
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
                        title: const Text('Acción'),
                        value: _isActionFavorite,
                        selected: _isActionFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isActionFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Aventura'),
                        value: _isAdventureFavorite,
                        selected: _isAdventureFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAdventureFavorite = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Drama'),
                        value: _isDramaFavorite,
                        selected: _isDramaFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isDramaFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Fantasia'),
                        value: _isFantasyFavorite,
                        selected: _isFantasyFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isFantasyFavorite = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Ficción'),
                        value: _isFictionFavorite,
                        selected: _isFictionFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isFictionFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Romance'),
                        value: _isRomanceFavorite,
                        selected: _isRomanceFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isRomanceFavorite = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Suspenso'),
                        value: _isSuspenseFavorite,
                        selected: _isSuspenseFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isSuspenseFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Terror'),
                        value: _isTerrorFavorite,
                        selected: _isTerrorFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isTerrorFavorite = value!;
                          });
                        },
                      ),
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
      if (_password.text.isEmpty ||
          _repPassword.text.isEmpty ||
          _email.text.isEmpty) {
        showMessage("ERROR: Debe digitar correo electrónico y las contraseñas");
      } else {
        if (!_email.text.isValidEmail()) {
          showMessage("ERROR: El correo electrónico no es válido");
        } else {
          if (!Utils.isSizePasswordValid(_password.text)) {
            showMessage(
                "ERROR: La contraseña debe tener mas de 6 o más digitos");
          } else {
            if (_password.text == _repPassword.text) {
              //   var user = User(_name.text, _email.text, _password.text);
              //   _saveUser(user);
              registerUser();
              //   Navigator.pop(context);
            } else {
              showMessage("ERROR: Las contraseñas no son iguales");
            }
          }
        }
      }
    });
  }

  Future<void> registerUser() async {
    var result = await _firebaseApi.registerUser(_email.text, _password.text);
    print("Resultado $result");
    if (result == 'weak-password') {
      showMessage('La contraseña debe tener 6 o más caracteres');
    } else if (result == 'email-already-in-use') {
      showMessage('Ya existe una cuenta con ese correo electrónico.');
    } else if (result == "invalid-email") {
      showMessage("El correo electrónico es inválido");
    } else if (result == "network-request-failed") {
      showMessage("Revise su conexión a internet");
    } else {
      //registro exitoso
      createUser(result);
    }
  }

  Future<void> createUser(Object? uid) async {
    String genre = _genre == Genre.male ? "Masculino" : "Femenino";
    var user = User(
        _city.text,
        _birthDate,
        _email.text,
        _name.text,
        genre,
        _isActionFavorite,
        _isAdventureFavorite,
        _isDramaFavorite,
        _isFantasyFavorite,
        _isFictionFavorite,
        _isRomanceFavorite,
        _isSuspenseFavorite,
        _isTerrorFavorite,
        uid,
        "");
    var result = await _firebaseApi.createUser(user);
    if (result == "network-request-failed") {
      showMessage("Revise su conexión a internet");
    } else {
      //Creacion exitosa
      Navigator.pop(context);
    }
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }
}

extension on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

//Marzo 21 de 2024
//Abril 4 de 2024
