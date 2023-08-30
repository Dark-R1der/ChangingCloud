import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> singInWithEmailPass({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailandPassword({
    required String email,
    required String password,
    required String role,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firebaseFirestore
        .collection('/users')
        .doc(email)
        .set({'role': role.toLowerCase()});

    if (role == "Node") {
      await _firebaseFirestore
          .collection('/users')
          .doc(email)
          .update({'current_files': 0, 'max_file_limit': 10});
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
