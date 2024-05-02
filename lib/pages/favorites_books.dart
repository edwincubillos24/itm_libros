import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import '../models/local_book.dart';

class FavoritesBooksPage extends StatefulWidget {
  const FavoritesBooksPage({super.key});

  @override
  State<FavoritesBooksPage> createState() => _FavoritesBooksPageState();
}

class _FavoritesBooksPageState extends State<FavoritesBooksPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<LocalBook>>(
        valueListenable: Boxes.getFavoritesBox().listenable(),
        builder: (context, box, _) {
          final booksBox = box.values.toList().cast<LocalBook>();
          return ListView.builder(
            itemCount: booksBox.length,
            itemBuilder: (BuildContext context, int index) {
              final book = booksBox[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    book.bookImage ?? "",
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Image(
                        image: AssetImage('assets/images/logo.png'),
                      );
                    },
                  ),
                  title: Text(book.title ?? "No title"),
                  subtitle: Text(book.author ?? "No author"),
                  onLongPress: () {
                    setState(() {
                      showAlertDialog(context, book);
                    });
                  },
                ),
              );
            },
          );
        });
  }

  showAlertDialog(BuildContext context, LocalBook book) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content: const Text("¿Está seguro que desea eliminar el libro?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
            child: const Text('OK'),
            onPressed: () => {
                  book.delete(),
                  Navigator.pop(context, 'OK'),
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
}
