import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {

  Future<bool> registerUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } return false;
    } catch (e) {
      print("hola el error es $e");
      return false;
    }
  }

  void loginUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

}
