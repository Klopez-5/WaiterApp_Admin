import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}

class SignUpData {
  final String name;
  final String lastname;
  final String email;
  final String password;
  final String number;
  final String address;

  SignUpData(
      {required this.name,
      required this.lastname,
      required this.email,
      required this.password,
      required this.number,
      required this.address});
}

class SignUpResponse {
  final String? error;
  final User? user;

  SignUpResponse(this.error, this.user);
}
