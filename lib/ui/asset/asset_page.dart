// lib/screens/asset_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/controller/getx_assets_page_controller.dart';

import '../../components/asset/asset_tree_refactor.dart';

class AssetPage extends StatelessWidget {
  AssetPage();

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<GetxAssetsPageController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar Ativo ou Local',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  presenter.searchQuery.value = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      presenter.toggleEnergyFilter();
                    },
                    child: Text('Sensor de Energia'),
                    style: ElevatedButton.styleFrom(
                      primary: presenter.showEnergySensors.value
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      presenter.toggleCriticalFilter();
                    },
                    child: Text('Crítico'),
                    style: ElevatedButton.styleFrom(
                      primary: presenter.showCriticalStatus.value
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (presenter.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return AssetTree(
                  locations: presenter.filteredLocations,
                  assets: presenter.filteredAssets,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
