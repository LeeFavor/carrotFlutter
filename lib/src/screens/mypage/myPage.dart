import 'package:carrot_flutter/src/screens/controllers/userController.dart';
import 'package:carrot_flutter/src/screens/mypage/userMypage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// UserMypage(UserModel(id: 1, name: '홍길동')),
            Obx(
              () {
                if (userController.my.value == null) {
                  return const CircularProgressIndicator();
                } else {
                  return UserMypage(userController.my.value!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
