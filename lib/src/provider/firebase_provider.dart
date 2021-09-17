import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:waiterapp_admin_v6/src/model/users.dart';

class FirebaseProvider {
//Se optiene el usuario actual
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No se ha autenticado');
    return user;
  }

//Se abrevia para no buscar
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  Future<MyUser?> getMyUser() async {
    final snapshot = await firestore.doc('users/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> saveMyUser(MyUser user, File? image) async {
    final ref = firestore.doc('users/${currentUser.uid}');
    if (image != null) {
      final imagePath =
          '${currentUser.uid}/profile/${path.basename(image.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      await ref.set(user.toFirebaseMap(newImage: url), SetOptions(merge: true));
    } else {
      await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}
