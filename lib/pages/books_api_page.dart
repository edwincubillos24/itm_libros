import 'package:flutter/material.dart';

import '../models/response_api.dart';
import '../repository/books_api.dart';
import 'detail_api_book_page.dart';

class BooksApiPage extends StatefulWidget {
  const BooksApiPage({super.key});

  @override
  State<BooksApiPage> createState() => _BooksApiPageState();
}

class _BooksApiPageState extends State<BooksApiPage> {
  final _parametro = TextEditingController();
  final BooksApi booksApi = BooksApi();

  List<Books> listBook = <Books>[];

  Future _getBooks() async {
    var resultsFuture = await booksApi.getBooks(_parametro.text);
    setState(() {
      resultsFuture.results?.lists?.forEach(
        (list) {
          list.books?.forEach((book) {
            listBook.add(book);
            print("libro: ${book.title}");
          });
        },
      );
    });
  }

  @override
  void initState() {
    _getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Expanded(
            child: ListView.builder(
              itemCount: listBook.length,
              itemBuilder: (BuildContext context, int index) {
                Books book = listBook[index];
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
                    subtitle: Text(book.author ?? "No publishedDate"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailApiBookPage(book)));
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
