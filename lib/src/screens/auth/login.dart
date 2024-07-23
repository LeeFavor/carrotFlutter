import 'package:carrot_flutter/src/home.dart';
import 'package:carrot_flutter/src/screens/controllers/authController.dart';
import 'package:carrot_flutter/src/screens/widgets/forms/labelTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../controllers/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final authController = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  // login(String phone, String password) async {
  // Map body = await authProvider.login(phone, password);
  //   if (body['result'] == 'ok') {
  //   return true;
  //   }
  //   Get.snackbar('로그인 에러', body['message'],
  //   snackPosition: SnackPosition.BOTTOM);
  //   return false;
  // }
  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      authController.updateButtonState(_phoneController);
    });
  }

  @override
  void dispose() {
    _phoneController.removeListener(() {
      authController.updateButtonState(_phoneController);
    });
    super.dispose();
  }

  _submit() async {
    bool result = await authController.login(
      _phoneController.text,
      _passwordController.text,
    );
    if (result) {
      Get.offAll(() => Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            LabelTextField(
              label: '휴대폰 번호',
              hintText: '휴대폰 번호를 입력해주세요',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요',
              controller: _passwordController,
              isObscure: true,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
