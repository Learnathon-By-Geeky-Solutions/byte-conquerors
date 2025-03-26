import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AuthRepositoryImpl {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login Method
  Future<String?> login(
      {required String email, required String password}) async {
    if (!GetUtils.isEmail(email) || password.length < 8) {
      return !GetUtils.isEmail(email)
          ? 'Invalid email format'
          : 'Password must be at least 8 characters long';
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Login failed. Please try again.';
    }
  }

  // Signup Method
  Future<String?> signUp(
      {required String email, required String password}) async {
    if (!GetUtils.isEmail(email) || password.length < 8) {
      return !GetUtils.isEmail(email)
          ? 'Invalid email format'
          : 'Password must be at least 8 characters long';
    }

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Signup failed. Please try again.';
    }
  }
}
