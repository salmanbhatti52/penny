import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/data/models/signup_models.dart';
import '../../core/constants/api_constants.dart';

class SignUpProvider with ChangeNotifier {
  bool _isLoading = false;
  SignUpModel _signUpModel = SignUpModel();

  bool get isLoading => _isLoading;
  SignUpModel get signUpModel => _signUpModel;

  Future<void> signUpUser(String email, String password, String name) async {
    String apiUrl = "${ApiConstants.baseUrl}/signup";
    print("api: $apiUrl");
    print("email: $email");
    print("password: ${password.trim()}");
    print("name: ${name.trim()}");

    _isLoading = true;
    notifyListeners();

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": password,
      "user_name": name,
      "account_type": "SignupWithApp",
      "one_signal_id": "123"
    });

    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 signUp");
      print("SuccessFull");
      _signUpModel = signUpModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('signUpModel status: ${_signUpModel.status}');
  }
}
