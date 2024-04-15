import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Book.dart';
import '../repository/firebase_api.dart';

class NewBookPage extends StatefulWidget {
  const NewBookPage({super.key});

  @override
  State<NewBookPage> createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _author = TextEditingController();
  final _pages = TextEditingController();

  double _rating = 3.0;

  bool _isActionFavorite = false,
      _isAdventureFavorite = false,
      _isDramaFavorite = false;
  bool _isFantasyFavorite = false,
      _isFictionFavorite = false,
      _isRomanceFavorite = false;
  bool _isSuspenseFavorite = false, _isTerrorFavorite = false;

  Future<void> _saveBook() async{
    var book = Book ("", _name.text, _author.text, _pages.text, _rating, _isActionFavorite,
      _isAdventureFavorite,
      _isDramaFavorite,
      _isFantasyFavorite,
      _isFictionFavorite,
      _isRomanceFavorite,
      _isSuspenseFavorite,
      _isTerrorFavorite,
      "");
    var result = await _firebaseApi.createBook(book);
    if (result == "network-request-failed") {
      showMessage("Revise su conexión a internet");
    } else {
      //Creacion exitosa
      Navigator.pop(context);
    }
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      appBar: AppBar(
        title: const Text('Nuevo Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
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
                height: 16.0,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Autor'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _pages,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Páginas'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Género(s) del libro',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16.0,
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
                onPressed: () {
                  _saveBook();
                },
                child: const Text('Guardar libro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
