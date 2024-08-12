import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/openPostModel.dart';

class OpenPostProvider with ChangeNotifier {
  bool _isLoading = false;
  OpenProfilePostModel _openProfilePostModel = OpenProfilePostModel();
  List<String> _imageUrls = [];
  List<String> _quotedImageUrls = [];
  int _currentPage = 0; // Track the current page index
  bool get isLoading => _isLoading;
  OpenProfilePostModel get openProfilePostModel => _openProfilePostModel;
  List<String> get imageUrls => _imageUrls;
  List<String> get quotedImageUrls => _quotedImageUrls;
  int get currentPage => _currentPage; // Getter for currentPage

  set currentPage(int value) {
    _currentPage = value; // Setter for currentPage
    notifyListeners(); // Notify listeners when currentPage changes
  }

  Future<void> getAllPost(String id, int pennyId) async {
    String apiUrl = "${ApiConstants.baseUrl}/get_place";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    var data = {
      "users_customers_id": id,
      "penny_places_id": pennyId.toString(),
    };
    print("$data");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "users_customers_id": id,
          "penny_places_id": pennyId.toString(),
        },
      );

      final responseString = response.body;
      print("get_place: $responseString");
      print("status Code get_place: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("in 200 get_place");
        print("SuccessFull");
        _openProfilePostModel = openProfilePostModelFromJson(responseString);

        _imageUrls = _openProfilePostModel.data
                ?.expand((datum) =>
                    datum.images.map((image) {
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
      } else {
        print("Error fetching places: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching places: $error");
    }

    _isLoading = false;
    notifyListeners();

    print('get_place status: ${_openProfilePostModel.status}');
  }

  Future<void> refreshData(String id, int pennyId) async {
    await getAllPost(id, pennyId);
    notifyListeners();
  }

  Future<void> likeComment(
      String userId, String placeId, String reviewId) async {
    String apiUrl = "${ApiConstants.baseUrl}/like_review";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "users_customers_id": userId,
          "place_id": placeId,
          "place_reviews_id": reviewId,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // Update the state to reflect the new like status
          print("Zain");
          notifyListeners();
        }
      } else {
        print("Error liking comment: ${response.statusCode}");
      }
    } catch (error) {
      print("Error liking comment: $error");
    }
  }
}
