import 'package:get/get.dart';
import 'package:tractian/controller/bind/http_server.dart';
import 'package:tractian/controller/getx_assets_page_controller.dart';

class AssetsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetxAssetsPageController>(
        () => GetxAssetsPageController(apiService: makeApiService()));
  }
}
