import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/fetch_places_model.dart';

class FetchPlacesPostProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isFirstLoad = false;
  FetchPlacesPostProvider() {
    resetFirstLoad();
  }

  void resetFirstLoad() {
    _isFirstLoad = true;
    notifyListeners();
  }

  FetchPlacesModel _fetchPlacesModel = FetchPlacesModel();
  List<String> _imageUrls = [];
  List<String> _quotedImageUrls = [];
  int _currentPage = 0; // Track the current page index
  bool get isFirstLoad => _isFirstLoad;
  bool get isLoading => _isLoading;
  FetchPlacesModel get fetchPlacesModel => _fetchPlacesModel;
  List<String> get imageUrls => _imageUrls;
  List<String> get quotedImageUrls => _quotedImageUrls;
  int get currentPage => _currentPage; // Getter for currentPage
  List<Datum> _filteredPlaces = [];

  List<Datum> get filteredPlaces =>
      _filteredPlaces.isEmpty ? _fetchPlacesModel.data ?? [] : _filteredPlaces;

  void filterPlaces(String keyword) {
    if (keyword.isEmpty) {
      _filteredPlaces = [];
    } else {
      _filteredPlaces = _fetchPlacesModel.data
              ?.where((place) =>
                  place.placeName
                          ?.toLowerCase()
                          .contains(keyword.toLowerCase()) ==
                      true ||
                  place.placeDescription
                          ?.toLowerCase()
                          .contains(keyword.toLowerCase()) ==
                      true ||
                  place.placeLocation
                          ?.toLowerCase()
                          .contains(keyword.toLowerCase()) ==
                      true ||
                  place.placeTypeName
                          ?.toLowerCase()
                          .contains(keyword.toLowerCase()) ==
                      true ||
                  place.user!.username
                          ?.toLowerCase()
                          .contains(keyword.toLowerCase()) ==
                      true)
              .toList() ??
          [];
    }
    print("_filteredPlaces:");
    for (int i = 0; i < _filteredPlaces.length; i++) {
      var place = _filteredPlaces[i];
      print(
          "Place $i: ID: ${place.palaceId}, Name: ${place.placeName}, Description: ${place.placeDescription}");
    }
    notifyListeners();
  }

  set currentPage(int value) {
    _currentPage = value; // Setter for currentPage
    notifyListeners(); // Notify listeners when currentPage changes
  }

  Future<void> getAllPost(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/fetch_places";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "users_customers_id": id,
        },
      );

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
      } else {
        print("Error fetching places: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching places: $error");
    }

    _isLoading = false;
    _isFirstLoad = false;
    notifyListeners();

    print('fetch_places status: ${_fetchPlacesModel.status}');
  }

  Future<void> refreshData(String id) async {
    await getAllPost(id);
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
