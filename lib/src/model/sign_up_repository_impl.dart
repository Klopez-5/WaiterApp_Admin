import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:waiterapp_admin_v6/src/repository/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
      await UserCredential.user!.updateDisplayName(
          "${data.name} ${data.lastname} ${data.number} ${data.address}");
      return SignUpResponse(null, UserCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(e.code, null);
    }
  }
}
