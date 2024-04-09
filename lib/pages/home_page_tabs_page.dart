import 'package:flutter/material.dart';
import 'package:itm_libros/pages/profile_page.dart';

import 'books_api_page.dart';
import 'books_store_page.dart';
import 'my_books_page.dart';

class HomePageTabsPage extends StatefulWidget {
  const HomePageTabsPage({super.key});

  @override
  State<HomePageTabsPage> createState() => _HomePageTabsPageState();
}

class _HomePageTabsPageState extends State<HomePageTabsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Image.asset('assets/images/mislibros.png')),
                      Tab(icon: Image.asset('assets/images/bookapi.png')),
                      Tab(icon: Image.asset('assets/images/bookstore.png')),
                      const Tab(icon: Icon(Icons.person, color: Colors.black)),
                    ],
                  ),
                  title: const Text('Mis Records'),
                ),
                body: const TabBarView(
                  children: [
                    MyBooksPage(),
                    BooksApiPage(),
                    BooksStorePage(),
                    ProfilePage(),
                  ],
                )
            )
        )
    );
  }
}
