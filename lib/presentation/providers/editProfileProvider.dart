import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/edit_profile_model.dart';

class EditProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  EditProfileModel _editProfileModel = EditProfileModel();

  bool get isLoading => _isLoading;
  EditProfileModel get editProfileModel => _editProfileModel;

  Future<void> editProfile(
      String id, String name, String bio, String? profilePic) async {
    String apiUrl = "${ApiConstants.baseUrl}/edit_bio";
    print("api: $apiUrl");

    _isLoading = true;
    notifyListeners();

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "users_customers_id": id,
      "user_name": name,
      "profile_bio": bio,
      "profile_picture": profilePic
    });

    final responseString = response.body;
    print("edit_bio: $responseString");
    print("status Code edit_bio: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 edit_bio");
      print("SuccessFull");
      _editProfileModel = editProfileModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('edit_bio status: ${_editProfileModel.status}');
  }
}
