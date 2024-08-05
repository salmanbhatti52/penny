import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/add_places_model.dart';

class AddPlacesProvider with ChangeNotifier {
  bool _isLoading = false;
  AddPlacesModel _addPlacesModel = AddPlacesModel();

  bool get isLoading => _isLoading;
  AddPlacesModel get addPlacesModel => _addPlacesModel;
  Future<void> addPlaces(
      String id,
      String placeName,
      String location,
      String placeType,
      String ratings,
      String notes,
      String postType,
      String lat,
      String lng,
      List imageList) async {
    String apiUrl = "${ApiConstants.baseUrl}/place_add";
    print("api: $apiUrl");

    _isLoading = true;
    notifyListeners();

    // Convert the image list to JSON
    final String imagesJson = jsonEncode(imageList);
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "users_customers_id": id,
          "place_type": placeType,
          "name": placeName,
          "location": location,
          "longitude": lat,
          "lattitude": lng,
          "visibility_flag": postType,
          "rating": ratings,
          "description": notes,
          "images": imagesJson,
        }));

    final responseString = response.body;
    print("addPlaces: $responseString");
    print("status Code addPlaces: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 addPlaces");
      print("SuccessFull");
      _addPlacesModel = addPlacesModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('addPlaces status: ${_addPlacesModel.status}');
    // var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    // var url = Uri.parse('${ApiConstants.baseUrl}/place_add');

    // var body = {
    //   "users_customers_id": id,
    //   "place_type": placeType,
    //   "name": placeName,
    //   "location": location,
    //   "longitude": lat,
    //   "lattitude": lng,
    //   "visibility_flag": postType,
    //   "rating": ratings,
    //   "description": notes,
    //   "images": imageList,
    // };

    // var req = http.Request('POST', url);
    // req.headers.addAll(headersList);
    // req.body = json.encode(body);

    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    // if (res.statusCode == 200) {
    //   _addPlacesModel = addPlacesModelFromJson(resBody);

    //   print(resBody);
    //   _isLoading = false;
    //   notifyListeners();
    // }
    // print('addPlaces status: ${_addPlacesModel.status}');
  }
}
