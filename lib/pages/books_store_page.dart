import 'package:flutter/material.dart';

class BooksStorePage extends StatefulWidget {
  const BooksStorePage({super.key});

  @override
  State<BooksStorePage> createState() => _BooksStorePageState();
}

class _BooksStorePageState extends State<BooksStorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tiendas de libros'),
      ),
    );
  }
}
