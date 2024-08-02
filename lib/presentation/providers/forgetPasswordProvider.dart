import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';

import 'package:penny_places/data/models/forget_password_model.dart';

class ForgetPasswordProvider with ChangeNotifier {
  bool _isLoading = false;
  ForgetPasswordModel _forgetPasswordModel = ForgetPasswordModel();

  bool get isLoading => _isLoading;
  ForgetPasswordModel get forgetPasswordModel => _forgetPasswordModel;

  Future<void> forgetPasswordUser(String email) async {
      String apiUrl = "${ApiConstants.baseUrl}/forgot_password";
    print("api: $apiUrl");
    print("email: $email");

    _isLoading = true;
    notifyListeners();

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
    });

    final responseString = response.body;
    print("responseForgetPasswordApi: $responseString");
    print("status Code ForgetPassword: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 ForgetPassword");
      print("SuccessFull");
      _forgetPasswordModel = forgetPasswordModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('ForgetPassword status: ${_forgetPasswordModel.status}');
  }
}
