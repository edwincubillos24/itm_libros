import 'package:flutter/material.dart';

import '../boxes.dart';
import '../models/local_book.dart';
import '../models/response_api.dart';

class DetailApiBookPage extends StatefulWidget {
  final Books book;

  const DetailApiBookPage(this.book, {super.key});

  @override
  State<DetailApiBookPage> createState() => _DetailApiBookPageState(book);
}

class _DetailApiBookPageState extends State<DetailApiBookPage> {
  final Books book;

  _DetailApiBookPageState(this.book);

  var isFavorite = false;

  @override
  void initState() {
    _getFavoritesBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title ?? "Title"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                book.bookImage ?? "",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Image(
                    image: AssetImage('assets/images/logo.png'),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border),
                      color: Colors.red,
                      onPressed: (() {
                        _onFavoriteButtonClicked();
                      }),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Autor: ${book.author}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Editorial: ${book.publisher}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.description ?? "No Description",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getFavoritesBooks() {
    final box = Boxes.getFavoritesBox();
    box.values.forEach((element) {
      if (element.title == book.title) {
        print("${element.title} esta en favoritos");
        isFavorite = true;
      }
    });
  }

  void _onFavoriteButtonClicked() async {
    var localBook = LocalBook()
      ..title = book.title
      ..author = book.author
      ..bookImage = book.bookImage
      ..publisher = book.publisher
      ..description = book.description;

    final box = Boxes.getFavoritesBox();
    // box.add(localBook);
    if (isFavorite) {
      print("eliminado");
      box.delete(localBook.title);
    } else {
      print("agregado");
      box.put(localBook.title, localBook);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

}
