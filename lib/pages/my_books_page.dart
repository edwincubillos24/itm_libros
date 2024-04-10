import 'package:flutter/material.dart';

import 'new_book_page.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  void _addButtonClicked() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewBookPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Center(
        child: Text('Mis Libros'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addButtonClicked, child: const Icon(Icons.add)),
    );
  }
}
