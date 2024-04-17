import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Book.dart';
import '../models/User.dart' as UserApp;

class FirebaseApi {
  Future<Object?> registerUser(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } catch (e) {
      print("Exception $e");
    }
  }

  Future<Object?> loginUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } catch (e) {
      print("Exception $e");
    }
  }

  Future<String> createUser(UserApp.User user) async {
    try {
      //final document = await FirebaseFirestore.instance.collection("users").add(user.toJson());  //con id automatico
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(user.toJson()); //setteando id
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    }
  }

  Future<String> createBook(Book book, File? image) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc();
      book.id = document.id;

      final storageRef = FirebaseStorage.instance.ref();
      final bookPicturesRef = storageRef.child("books").child("${book.id}.jpg");
      final resultSavePicture = await bookPicturesRef.putFile(image!);
      book.urlPicture = await bookPicturesRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc(book.id)
          .set(book.toJson());
      await FirebaseFirestore.instance
          .collection("books")
          .doc(book.id)
          .set(book.toJson());
      return document.id;
    } on FirebaseException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    }
  }

  Future<String> deleteBook(QueryDocumentSnapshot book) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc(book.id)
          .delete();
      return uid!;
    } on FirebaseException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    }
  }
}
