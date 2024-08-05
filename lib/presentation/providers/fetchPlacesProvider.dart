import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/fetch_places_model.dart';

class FetchPlacesPostProvider with ChangeNotifier {
  bool _isLoading = false;
  FetchPlacesModel _fetchPlacesModel = FetchPlacesModel();
  List<String> _imageUrls = [];
  List<String> _quotedImageUrls = [];

  bool get isLoading => _isLoading;
  FetchPlacesModel get fetchPlacesModel => _fetchPlacesModel;
  List<String> get imageUrls => _imageUrls;
  List<String> get quotedImageUrls => _quotedImageUrls;

  Future<void> getAllPost(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/fetch_places";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "users_customers_id": id,
    });

    final responseString = response.body;
    print("fetch_places: $responseString");
    print("status Code fetch_places: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 fetch_places");
      print("SuccessFull");
      _fetchPlacesModel = fetchPlacesModelFromJson(responseString);
      _imageUrls = _fetchPlacesModel.data
              ?.expand((datum) =>
                  datum.images?.map((image) {
                    final url =
                        "${ApiConstants.imageBaseUrl}/${image.imageName ?? ''}";
                    return url.toString();
                  }) ??
                  [])
              .toList()
              .cast<String>() ??
          [];

      print("_imageUrls: $_imageUrls");
      _quotedImageUrls = _imageUrls.map((url) => '"$url"').toList();
      debugPrint("quotedImageUrls: $quotedImageUrls");
      // JSON encode the list
      String jsonEncodedUrls = jsonEncode(_imageUrls);
      print("JSON Encoded _imageUrls: $jsonEncodedUrls");
    }

    _isLoading = false;
    notifyListeners();

    print('fetch_places status: ${_fetchPlacesModel.status}');
  }
}
