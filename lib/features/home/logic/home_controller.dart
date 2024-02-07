import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/my_services.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  MyServices services = Get.find();
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
