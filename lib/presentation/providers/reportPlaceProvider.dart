import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/report_place_model.dart';

class ReportPlacesProvider with ChangeNotifier {
  bool _isLoading = false;

  ReportPlacesModel _reportPlacesModel = ReportPlacesModel();

  bool get isLoading => _isLoading;
  ReportPlacesModel get reportPlacesModel => _reportPlacesModel;

  Future<void> reportPlace(String userId, String pennyId) async {
    String apiUrl = "${ApiConstants.baseUrl}/report_post";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "users_customers_id": userId,
      "place_id": pennyId
    });

    final responseString = response.body;
    print("report_post: $responseString");
    print("status Code report_post: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 report_post");
      print("SuccessFull");
      _reportPlacesModel = reportPlacesModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('report_post status: ${_reportPlacesModel.status}');
  }
}
