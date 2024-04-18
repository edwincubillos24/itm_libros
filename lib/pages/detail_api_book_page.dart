import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title ?? "Detalle"),
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
}
