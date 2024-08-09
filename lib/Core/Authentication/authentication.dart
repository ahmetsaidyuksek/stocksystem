import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  static final Authentication _instance = Authentication._internal();

  factory Authentication() => _instance;

  Authentication._internal();

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  authenticationInitialize() async {
    if (firebaseAuth.currentUser != null) {
      try {
        await firebaseAuth.currentUser!.reload();
      } on FirebaseAuthException catch (firebaseAuthException) {
        Fluttertoast.showToast(
          msg: "Auth Initialize Error: ${firebaseAuthException.code}",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
    firebaseAuth.authStateChanges().listen((User? user) => user != null ? _isAuthenticated = true : _isAuthenticated = false);
    firebaseAuth.userChanges().listen((User? user) => user != null ? _isAuthenticated = true : _isAuthenticated = false);
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) return true;
    } on FirebaseAuthException catch (firebaseAuthException) {
      Fluttertoast.showToast(
        msg: "Auth Sign In Error: ${firebaseAuthException.code}",
        toastLength: Toast.LENGTH_LONG,
      );

      return false;
    }
    return false;
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) return true;
    } on FirebaseAuthException catch (firebaseAuthException) {
      Fluttertoast.showToast(
        msg: "Auth Sign Up Error: ${firebaseAuthException.code}",
        toastLength: Toast.LENGTH_LONG,
      );

      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();

      return true;
    } on FirebaseAuthException catch (firebaseAuthException) {
      Fluttertoast.showToast(
        msg: "Auth Sign Out Error: ${firebaseAuthException.code}",
        toastLength: Toast.LENGTH_LONG,
      );
    }

    return false;
  }
}
