import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itm_libros/pages/home_page_navigation_drawer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/firebase_api.dart';
import 'home_page_navigation_bar_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
    //  throw Exception(); //Prueba Crashlytics

      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        } else {

          //cargar los roles
          var tipoUsuario = await _firebaseApi.loadUser();
          _saveRol(tipoUsuario);
          if (tipoUsuario == "admin") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageNavigationBarPage(),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageNavigationDrawerPage(),
                ));
          }
        }
      });
    });
  }

  void _saveRol(String rol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("rol", rol);
  }

  @override
  void initState() {
    _closeSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 200,
              height: 200,
            ),
          ],
        )),
      ),
    );
  }
}
