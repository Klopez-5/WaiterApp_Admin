import 'dart:io';

import 'package:waiterapp_admin_v6/src/model/users.dart';
import 'package:waiterapp_admin_v6/src/provider/firebase_provider.dart';

import '../my_user_repository.dart';

class MyUserRepository extends MyUserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image) =>
      provider.saveMyUser(user, image);
}
