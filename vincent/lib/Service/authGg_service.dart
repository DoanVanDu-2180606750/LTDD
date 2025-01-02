
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthGgService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log("Người dùng đã hủy quá trình đăng nhập Google.");
        return null; 
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      log("Lỗi đăng nhập Google: ${e.toString()}");
      return null;
    }
  }

  // // Create user with email and password
  // Future<User?> createUserWithEmailAndPassword(String email, String password) async {
  //   try {
  //     final UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //       email: email, 
  //       password: password,
  //     );
  //     return cred.user;
  //   } catch (e) {
  //     log("${e.toString()}");
  //     return null;
  //   }
  // }
  // // Login user with email and password
  // Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
  //   try {
  //     final UserCredential cred = await _auth.signInWithEmailAndPassword(
  //       email: email, 
  //       password: password,
  //     );
  //     return cred.user;
  //   } catch (e) {
  //     log("Email Login error: ${e.toString()}");
  //     return null;
  //   }
  // }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      log("User signed out successfully.");
    } catch (e) {
      log("Sign-Out error: ${e.toString()}");
    }
  }
}
