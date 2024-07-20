import 'package:carrot_flutter/src/screens/feed/index.dart';
import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> myTabs = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
  BottomNavigationBarItem(icon: Icon(Icons.feed), label: '동네'),
  BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline_rounded), label: '채팅'),
  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
];

final List<Widget> myTabItems = [
  FeedIndex(),
  Center(child: Text('동네')),
  Center(child: Text('채팅')),
  Center(child: Text('마이')),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _hideItem() {
    // Implement logic to hide the selected item
    print('Item hidden!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: myTabs,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: IndexedStack(index: _selectedIndex, children: myTabItems));
  }
}

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
                                  hideTap(); // Call the hideTap callback
                                  Navigator.pop(context);
                                  Navigator.pop(context);
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
                )),
          ],
        ));
  }
}
