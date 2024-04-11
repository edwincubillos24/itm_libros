import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class NewBookPage extends StatefulWidget {
  const NewBookPage({super.key});

  @override
  State<NewBookPage> createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  final _name = TextEditingController();
  final _author = TextEditingController();
  final _pages = TextEditingController();

  double _rating = 3.0;

  bool _esAccionFavorite = false,
      _esAventuraFavorite = false,
      _esCienciaFiccionFavorite = false;
  bool _esDramaFavorite = false,
      _esFantasiaFavorite = false,
      _esRomanceFavorite = false;
  bool _esSuspensoFavorite = false, _esTerrorFavorite = false;

  void _saveBook() {}

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
                      value: _esAccionFavorite,
                      selected: _esAccionFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esAccionFavorite = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Aventura'),
                      value: _esAventuraFavorite,
                      selected: _esAventuraFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esAventuraFavorite = value!;
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
                      title: const Text('Ciencia ficción'),
                      value: _esCienciaFiccionFavorite,
                      selected: _esCienciaFiccionFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esCienciaFiccionFavorite = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Drama'),
                      value: _esDramaFavorite,
                      selected: _esDramaFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esDramaFavorite = value!;
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
                      title: const Text('Fantasía'),
                      value: _esFantasiaFavorite,
                      selected: _esFantasiaFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esFantasiaFavorite = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Romance'),
                      value: _esRomanceFavorite,
                      selected: _esRomanceFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esRomanceFavorite = value!;
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
                      value: _esSuspensoFavorite,
                      selected: _esSuspensoFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esSuspensoFavorite = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Terror'),
                      value: _esTerrorFavorite,
                      selected: _esTerrorFavorite,
                      onChanged: (bool? value) {
                        setState(() {
                          _esTerrorFavorite = value!;
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
