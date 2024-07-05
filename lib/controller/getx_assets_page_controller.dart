import 'package:get/get.dart';
import 'package:tractian/infra/tractian_api_service.dart';
import 'package:tractian/models/assets_model.dart';
import 'package:tractian/models/location_model.dart';

class GetxAssetsPageController extends GetxController {
  final ApiService apiService;
  GetxAssetsPageController({required this.apiService});
  var locations = <LocationModel>[].obs;
  var assets = <AssetModel>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var showEnergySensors = false.obs;
  var showCriticalStatus = false.obs;

  var companyId = Get.arguments;

  @override
  void onInit() async {
    await loadLocations(companyId);
    await loadAssets(companyId);
    searchQuery.listen((_) => applyFilters());
    showEnergySensors.listen((_) => applyFilters());
    showCriticalStatus.listen((_) => applyFilters());
    super.onInit();
  }

  Future<void> loadLocations(String companyId) async {
    try {
      isLoading.value = true;
      var locationList = await apiService.fetchLocations(companyId);
      locations.value = locationList;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAssets(String companyId) async {
    try {
      isLoading(true);
      var assetList = await apiService.fetchAssets(companyId);
      assets.value = assetList;
    } finally {
      isLoading.value = false;
      applyFilters();
    }
  }

  void toggleEnergyFilter() {
    showEnergySensors.value = !showEnergySensors.value;
  }

  void toggleCriticalFilter() {
    showCriticalStatus.value = !showCriticalStatus.value;
  }

  List<LocationModel> get filteredLocations {
    List<LocationModel> filteredLocation = locations.value;
    if (searchQuery.isEmpty) {
      return filteredLocation;
    } else {
      return filteredLocation
          .where((location) => location.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<AssetModel> get filteredAssets {
    List<AssetModel> filtered = assets.value;
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((asset) => asset.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
    if (showEnergySensors.isTrue) {
      filtered =
          filtered.where((asset) => asset.sensorType == 'energy').toList();
    }
    if (showCriticalStatus.isTrue) {
      filtered = filtered.where((asset) => asset.status == 'critical').toList();
    }
    return filtered;
  }

  void applyFilters() {
    locations.refresh();
    assets.refresh();
  }
}
