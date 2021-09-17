import 'dart:io';

import 'package:waiterapp_admin_v6/src/model/users.dart';

abstract class MyUserRepositoryBase {
  Future<MyUser?> getMyUser();

  Future<void> saveMyUser(MyUser user, File? image);
}
