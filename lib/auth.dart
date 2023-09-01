import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:newiet/views/ui/controller/global_controller.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GlobalController globalController = Get.find<GlobalController>();

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
    String name = "",
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _firebaseAuth.currentUser!.updateDisplayName(name);
    await _firebaseFirestore
        .collection('/users')
        .doc(email)
        .set({'role': role.toLowerCase()});
    globalController.role.value = role;
    await globalController.saveRoleToSharedPreferences();
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
