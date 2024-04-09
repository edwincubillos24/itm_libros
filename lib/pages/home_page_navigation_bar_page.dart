import 'package:flutter/material.dart';
import 'package:itm_libros/pages/profile_page.dart';
import 'books_api_page.dart';
import 'books_store_page.dart';
import 'my_books_page.dart';

class HomePageNavigationBarPage extends StatefulWidget {
  const HomePageNavigationBarPage({super.key});

  @override
  State<HomePageNavigationBarPage> createState() => _HomePageNavigationBarPageState();
}

class _HomePageNavigationBarPageState extends State<HomePageNavigationBarPage> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyBooksPage(),
    BooksApiPage(),
    BooksStorePage(),
    ProfilePage()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis libros'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/mislibros.png'),
            label: 'Mis libros',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bookapi.png'),
            label: 'Api Libros',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bookstore.png'),
            label: 'Tienda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Mi Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
