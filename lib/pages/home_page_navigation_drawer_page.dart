import 'package:flutter/material.dart';
import 'package:itm_libros/pages/profile_page.dart';

import 'books_api_page.dart';
import 'books_store_page.dart';
import 'my_books_page.dart';

class HomePageNavigationDrawerPage extends StatefulWidget {
  const HomePageNavigationDrawerPage({super.key});

  @override
  State<HomePageNavigationDrawerPage> createState() => _HomePageNavigationDrawerPageState();
}

class _HomePageNavigationDrawerPageState extends State<HomePageNavigationDrawerPage> {

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
        title: const Text('Mis Libros'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Mis Libros Header')
              ),
              ListTile(
                leading: Image.asset('assets/images/mislibros.png'),
                title: const Text('Mis Libros'),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/bookapi.png'),
                title: const Text('Api Libros'),
                onTap:() {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/bookstore.png'),
                title: const Text('Tienda'),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: const Text('Mi Perfil'),
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
            ],
          )
      ),
    );
  }
}
