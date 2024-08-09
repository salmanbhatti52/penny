import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/places_type_model.dart';

class PlaceTypeProvider with ChangeNotifier {
  bool _isLoading = false;
  PlacesTypeModel _placesTypeModel = PlacesTypeModel();
  List<String> _placeTypes = [];

  bool get isLoading => _isLoading;
  PlacesTypeModel get placesTypeModel => _placesTypeModel;
  List<String> get placeTypes => _placeTypes;

  Future<void> getPlaceType(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/place_types";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final response = await Dio().post(apiUrl, data: {
        "users_customers_id": id,
      });

      final responseString = response.data.toString();
      print("place_types: $responseString");
      print("status Code place_types: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("in 200 place_types");
        print("SuccessFull");
        _placesTypeModel = PlacesTypeModel.fromJson(response.data);
        _placeTypes =
            _placesTypeModel.data!.map((datum) => datum.place).toList();
      }

      _isLoading = false;
      notifyListeners();

      print('place_types status: ${_placesTypeModel.status}');
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }
}
