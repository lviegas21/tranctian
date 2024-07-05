import 'package:get/get.dart';
import 'package:tractian/infra/tractian_api_service.dart';
import 'package:tractian/models/company_model.dart';

class GetxHomePageController extends GetxController {
  final ApiService apiService;
  GetxHomePageController({required this.apiService});

  var companies = <CompanyModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }

  void fetchCompanies() async {
    try {
      isLoading.value = true;
      var companyList = await apiService.fetchCompanies();
      companies.value = companyList;
    } finally {
      isLoading.value = false;
    }
  }
}
