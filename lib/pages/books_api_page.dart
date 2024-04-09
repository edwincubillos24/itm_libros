import 'package:flutter/material.dart';

class BooksApiPage extends StatefulWidget {
  const BooksApiPage({super.key});

  @override
  State<BooksApiPage> createState() => _BooksApiPageState();
}

class _BooksApiPageState extends State<BooksApiPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Api Books'),
      ),
    );
  }
}
