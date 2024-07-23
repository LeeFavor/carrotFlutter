import 'package:carrot_flutter/src/screens/controllers/feedController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/feedModel.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel item;
  const FeedEdit({required this.item, super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.find<FeedController>();
  late TextEditingController titleController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item.title);
    priceController = TextEditingController(text: "${widget.item.price}");
  }

  void _submit() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('물품 수정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('수정하기'),
            ),
          ],
        ),
      ),
    );
  }
}
