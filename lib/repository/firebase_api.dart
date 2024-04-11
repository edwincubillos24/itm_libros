import 'package:firebase_auth/firebase_auth.dart';

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
}
