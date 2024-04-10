import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  bool _esAccionFavorite = false, _esAventuraFavorite = false, _esCienciaFiccionFavorite = false;
  bool _esDramaFavorite = false, _esFantasiaFavorite = false, _esRomanceFavorite = false;
  bool _esSuspensoFavorite = false, _esTerrorFavorite = false;

  void _saveBook(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
