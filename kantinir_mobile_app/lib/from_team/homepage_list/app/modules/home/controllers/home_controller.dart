import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController; // Add this line
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
    // getHTTP();
  }

  void changeIndex(int index) {
    pageController.jumpToPage(index);
    currentIndex.value = index;
  }

  void getHTTP() async {
    final response = await dio.get('http://10.0.2.2:4100/app/getBooks');
    print(response);
    print("object");
  }
}
