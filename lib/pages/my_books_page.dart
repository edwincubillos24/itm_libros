import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itm_libros/repository/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_book_page.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  var rol = true;

  void _addButtonClicked() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewBookPage()));
    });
  }

  Future<bool> _getRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  /*  setState(() {
      rol = prefs.getString("rol") == "admin";
      print(rol);
    });*/
    return prefs.getString("rol") == "admin";
  }

  @override
  void initState() {
    _getRol();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("books")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot book = snapshot.data!.docs[index];
                return buildCard(book);
              },
            );
          },
        ),
      ),
      //if (_getRol)
      floatingActionButton: Visibility(
        visible: rol,
        child: FloatingActionButton(
            onPressed: _addButtonClicked, child: const Icon(Icons.add)),
      ),
    );
  }

  void deleteBook(QueryDocumentSnapshot book) {
    _firebaseApi.deleteBook(book);
  }

  showAlertDialog(BuildContext context, QueryDocumentSnapshot book) {
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
                  deleteBook(book),
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

  InkWell buildCard(QueryDocumentSnapshot book) {
    var heading = book['name'];
    var subheading = book['author'];
    var cardImage = book['urlPicture'] == ""
        ? const AssetImage('assets/images/logo.png') as ImageProvider
        : NetworkImage(book['urlPicture']);
    return InkWell(
      onTap: () {
        print("tab");
      },
      onLongPress: () {
        print("longClick");
        showAlertDialog(context, book);
      },
      child: Card(
          elevation: 4.0,
          child: Column(
            children: [
              ListTile(
                title: Text(heading,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                subtitle: Text(subheading,
                    style: TextStyle(color: Colors.black54, fontSize: 18)),
                /*   leading: Image.network(
                  book['urlPicture'] ?? "",
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Image(
                      image: AssetImage('assets/images/logo.png'),
                    );
                  },
                ),*/
              ),
              Container(
                height: 100.0,
                width: 100.0,
                child: Ink.image(
                  image: cardImage,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          )),
    );
  }
}
