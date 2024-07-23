import 'package:carrot_flutter/src/screens/controllers/userController.dart';
import 'package:carrot_flutter/src/screens/widgets/forms/labelTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEdit extends StatefulWidget {
  const MyEdit({super.key});
  @override
  State<MyEdit> createState() => _MyEditState();
}

class _MyEditState extends State<MyEdit> {
  final userController = Get.put(UserController());
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await userController.updateInfo(_nameController.text, null);
    if (result) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = userController.my.value!.name;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          LabelTextField(
            label: '닉네임',
            hintText: '닉네임을 입력해주세요',
            controller: _nameController,
          ),
// 버튼
          ElevatedButton(
            onPressed: _submit,
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
