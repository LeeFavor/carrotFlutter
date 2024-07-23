import 'package:carrot_flutter/src/models/userModel.dart';
import 'package:carrot_flutter/src/screens/mypage/myEdit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMypage extends StatelessWidget {
  final UserModel user;
  const UserMypage(this.user, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const MyEdit());
      },
    );
  }
}
