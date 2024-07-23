import '../shared/global.dart';
import 'package:carrot_flutter/src/models/userModel.dart';

class UserModel {
  late int id;
  late String name;
  int? profile;
  get profileUrl => (profile != null)
      ? "${Global.baseUrl}/file/$profile"
      : "lib/src/images/logo.jpg";
  UserModel({required this.id, required this.name});
  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
    profile = m['profile_id'];
  }
}
