import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/controller/getx_home_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<GetxHomePageController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACTIAN'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(23, 25, 45, 1),
      ),
      body: Obx(() {
        if (presenter.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(26.0),
          itemCount: presenter.companies.length,
          itemBuilder: (context, index) {
            final company = presenter.companies[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 26.0),
              child: ListTile(
                tileColor: Colors.blue,
                leading: const Icon(Icons.business, color: Colors.white),
                title: Text(
                  company.name,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.toNamed("/asset", arguments: company.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
