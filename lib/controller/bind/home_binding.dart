import 'package:get/get.dart';

import '../getx_home_page_controller.dart';
import 'http_server.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetxHomePageController>(
        () => GetxHomePageController(apiService: makeApiService()));
  }
}
