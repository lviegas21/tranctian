import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tractian/ui/home/home_page.dart';

import 'controller/bind/assets_binding.dart';
import 'controller/bind/home_binding.dart';
import 'ui/asset/asset_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());
    return GetMaterialApp(
      title: 'Disque Denuncia - MA',
      navigatorObservers: [routeObserver],
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: "/home",
            page: () => const HomePage(),
            transition: Transition.rightToLeftWithFade,
            binding: HomePageBinding()),
        GetPage(
            name: "/asset",
            page: () => AssetPage(),
            transition: Transition.rightToLeftWithFade,
            binding: AssetsPageBinding()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
