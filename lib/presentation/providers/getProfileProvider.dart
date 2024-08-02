import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/get_profile_model.dart';
import 'dart:convert';

class GetProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  GetProfileModel _getProfileModel = GetProfileModel();

  bool get isLoading => _isLoading;
  GetProfileModel get getProfileModel => _getProfileModel;

  Future<void> getProfile(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/get_profile";
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
    print("get_profile: $responseString");
    print("status Code get_profile: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 get_profile");
      print("SuccessFull");
      _getProfileModel = getProfileModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('get_profile status: ${_getProfileModel.status}');
  }

  Future<String> convertImageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return base64Encode(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<Map<String, dynamic>> fetchProfileAndConvertImage(String userID) async {
    await getProfile(userID);
    final base64Image = await convertImageToBase64("https://penny.eigix.net/public/${_getProfileModel.data!.profilePicture}");
    return {
      'profile': _getProfileModel,
      'base64Image': base64Image,
    };
  }
}
