// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tractian/models/assets_model.dart';
import 'package:tractian/models/company_model.dart';
import 'package:tractian/models/location_model.dart';

class ApiService {
  static const baseUrl = 'https://fake-api.tractian.com';

  Future<List<CompanyModel>> fetchCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/companies'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CompanyModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }

  Future<List<LocationModel>> fetchLocations(String companyId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/companies/$companyId/locations'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<List<AssetModel>> fetchAssets(String companyId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/companies/$companyId/assets'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AssetModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }
}
