import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/change_password_model.dart';

class ChangePasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  ChangePasswordModel _changePasswordModel = ChangePasswordModel();

  bool get isLoading => _isLoading;
  ChangePasswordModel get changePasswordModel => _changePasswordModel;

  Future<void> changePassword(String email, String oldPass, String password,
      String confirmPassword) async {
    String apiUrl = "${ApiConstants.baseUrl}/change_password";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "old_password": oldPass,
      "password": password,
      "confirm_password": confirmPassword
    });

    final responseString = response.body;
    print("change_password: $responseString");
    print("status Code delete_account: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 change_password");
      print("SuccessFull");
      _changePasswordModel = changePasswordModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('change_password status: ${_changePasswordModel.status}');
  }
}
