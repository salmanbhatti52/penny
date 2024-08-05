import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/public_profile_post_model.dart';

class PrivatePostProvider with ChangeNotifier {
  bool _isLoading = false;
  PublicProfilePostModel _publicProfilePostModel = PublicProfilePostModel();
  List<String> _imageUrls = [];
  List<String> _quotedImageUrls = [];

  bool get isLoading => _isLoading;
  PublicProfilePostModel get publicProfilePostModel => _publicProfilePostModel;
  List<String> get imageUrls => _imageUrls;
  List<String> get quotedImageUrls => _quotedImageUrls;

  Future<void> getPrivatePost(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/fetch_user_places_private";
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
    print("fetch_user_places_public: $responseString");
    print("status Code fetch_user_places_public: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 fetch_user_places_public");
      print("SuccessFull");
      _publicProfilePostModel = publicProfilePostModelFromJson(responseString);
      _imageUrls = _publicProfilePostModel.data
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

      // print("_imageUrls: $_imageUrls");
      _quotedImageUrls = _imageUrls.map((url) => '"$url"').toList();
      // debugPrint("quotedImageUrls: $quotedImageUrls");
      // JSON encode the list
      String jsonEncodedUrls = jsonEncode(_imageUrls);
      // print("JSON Encoded _imageUrls: $jsonEncodedUrls");
    }

    _isLoading = false;
    notifyListeners();

    print('fetch_user_places_public status: ${_publicProfilePostModel.status}');
  }
}
