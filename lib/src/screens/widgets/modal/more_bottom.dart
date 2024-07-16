import 'package:flutter/material.dart';

class MoreBottomModal extends StatelessWidget {
  final VoidCallback cancelTap;
  final VoidCallback hideTap;
  
  const MoreBottomModal({required this.cancelTap, required this.hideTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.visibility_off_outlined),
                  title: Text('이 글 숨기기'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('이 글 숨기기'),
                          content: const Text('이 글을 숨기겠습니까? . . .'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                hideTap();
                                Navigator.pop(context);
                                Navigator.pop(context); // 이 부분은 두 번 pop 해야 하는지 확인 필요
                              },
                              child: const Text('숨기기'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('게시글 노출 기준'),
                ),
                ListTile(
                  leading: Icon(Icons.warning_amber_outlined),
                  title: Text('신고하기'),
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text("닫기", textAlign: TextAlign.center),
              onTap: cancelTap,
            ),
          ),
        ],
      ),
    );
  }
}