import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/reset_password_model.dart';

class ResetPasswordProvider with ChangeNotifier{
 bool _isLoading = false;
  ResetPasswordModel _resetPasswordModel = ResetPasswordModel();

  bool get isLoading => _isLoading;
  ResetPasswordModel get resetPasswordModel => _resetPasswordModel;

  Future<void> resetPasswordUser(String email, String password) async {
      String apiUrl = "${ApiConstants.baseUrl}/modify_forgot_password";
    print("api: $apiUrl");
    print("email: $email");

    _isLoading = true;
    notifyListeners();

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password":password
    });

    final responseString = response.body;
    print("responseResetPasswordApi: $responseString");
    print("status Code ResetPassword: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 ResetPassword");
      print("SuccessFull");
      _resetPasswordModel = resetPasswordModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('ResetPassword status: ${_resetPasswordModel.status}');
  }


}