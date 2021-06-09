import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to register with Email and Password (Sign Up)
  Future<String> registerWithEmailAndPassword(String merchantName, String email,
      String password, String phoneNumber) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // TODO: Implement logic to store additional merchant data
      return "Signed Up";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to sign out of Firebase
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
