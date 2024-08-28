import 'package:flutter/material.dart';
import 'package:get/get.dart';

class welcomepageController extends GetxController {
  final PageController controller = PageController();
  RxBool isLastPage = false.obs;

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}