import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content: const Text("¿Está seguro que desea cerrar sesión?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
            child: const Text('OK'),
            onPressed: () => {
                  FirebaseAuth.instance.signOut(),
                  Navigator.pop(context, 'OK'),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage())),
                }),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onCerrarSesionButtonClicked() {
    showAlertDialog(context);
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("Loading");
              }
              var user = snapshot.data!.data();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 170,
                      child: Stack(
                        children: [
                          image != null
                              ? Image.file(image!, width: 150, height: 150)
                              : const Image(
                                  image: AssetImage('assets/images/logo.png'),
                                  width: 150,
                                  height: 150,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              alignment: Alignment.bottomLeft,
                              onPressed: () async {
                                pickImage();
                              },
                              icon: const Icon(Icons.camera_alt),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 64.0,
                    ),
                    Text('Hola ${user?['name']}',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text('Correo:  ${user?['email']}',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text("Género: ${user?['genre']}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text("Generos Favoritos\n\n${cargarGenerosFavoritos(user)}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text("Fecha de nacimiento: ${user?['birthDate']} ",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text("Ciudad de nacimiento: ${user?['birthCity']} ",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 64.0,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      onPressed: _onCerrarSesionButtonClicked,
                      child: const Text("Cerrar sesión"),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  String cargarGenerosFavoritos(Map<String, dynamic>? user) {
    String _generosFavoritos = "";
    if (user?['isActionFavorite'] == true) _generosFavoritos = "Acción";
    if (user?['_isAdventureFavorite'] == true) _generosFavoritos += " Aventura";
    if (user?['_isDramaFavorite'] == true) _generosFavoritos += " Drama";
    if (user?['_isFantasyFavorite'] == true) _generosFavoritos += "Fantasia";
    if (user?['_isFictionFavorite'] == true) _generosFavoritos += "Ficción";
    if (user?['_isRomanceFavorite'] == true) _generosFavoritos += "Romance";
    if (user?['_isSuspenseFavorite'] == true) _generosFavoritos += "Suspenso";
    if (user?['_isTerrorFavorite'] == true) _generosFavoritos += "Terror";
    return _generosFavoritos;
  }
}
