import 'package:carrot_flutter/src/models/feedModel.dart';
import 'package:carrot_flutter/src/screens/controllers/feedController.dart';
import 'package:carrot_flutter/src/screens/feed/show.dart';
import 'package:carrot_flutter/src/screens/widgets/modal/confirmModal.dart';
import 'package:carrot_flutter/src/screens/widgets/modal/more_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel item;
  FeedListItem(this.item, {super.key});
  final feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(item.id));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 영역
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'lib/src/images/logo.jpg',
              width: _imageSize,
              height: _imageSize,
              fit: BoxFit.cover,
            ),
          ),
          // 정보 영역
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '동네이름',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '· N 분전',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    item.price.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // 기타 영역
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MoreBottomModal(
                    cancelTap: () {
                      Get.back();
                    },
                    hideTap: () {},
                    delete: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmModal(
                            title: '삭제 하기',
                            message: '이 글을 삭제하시겠습니까?',
                            confirmText: '삭제하기',
                            confirmAction: () async {
                              bool result =
                                  await feedController.feedDelete(item.id);
                              if (result) {
                                Get.back();
                                Get.back();
                              }
                            },
                            cancel: () {
                              Get.back();
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.grey,
              size: 16,
            ),
          ),

          Positioned(
            right: 10,
            bottom: 0,
            child: Row(
              children: [
                Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 16),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 4),
                Icon(Icons.favorite_border, color: Colors.grey, size: 16),
                SizedBox(width: 2),
                Text('1', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
