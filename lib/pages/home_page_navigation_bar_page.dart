import 'package:flutter/material.dart';
import 'package:itm_libros/pages/profile_page.dart';
import 'books_api_page.dart';
import 'books_store_page.dart';
import 'favorites_books.dart';
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
    FavoritesBooksPage(),
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
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/mislibros.png'),
            label: 'Mis libros',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bookapi.png', color: Colors.black,),
            label: 'Api Libros',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Favoritos'),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bookstore.png'),
            label: 'Tienda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: Colors.black),
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
