import 'dart:math';
import 'package:carrot_flutter/src/models/feedModel.dart';
import 'package:carrot_flutter/src/providers/feedProvider.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  final RxList<FeedModel> feedList = <FeedModel>[].obs;
  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null);
  // @override
  // void onInit() {
  //   super.onInit();
  //   _initialData();
  // }

  Future<void> feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    List<FeedModel> tmp =
        json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  Future<bool> feedCreate(
      String title, String price, String content, int? image) async {
    Map body = await feedProvider.store(title, price, content, image);
    if (body['result'] == 'ok') {
      await feedIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> feedShow(int id) async {
    Map body = await feedProvider.show(id);
    if (body['result'] == 'ok') {
      currentFeed.value = FeedModel.parse(body['data']);
    } else {
      Get.snackbar('피드 에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
      currentFeed.value = null;
    }
  }

  Future<bool> feedDelete(int id) async {
    Map body = await feedProvider.destroy(id);
    if (body['result'] == 'ok') {
      feedList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
