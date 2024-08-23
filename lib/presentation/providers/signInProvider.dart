import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/data/Data%20Sources/local_data_source.dart';
import 'package:penny_places/data/models/signin_model.dart';
import 'package:penny_places/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';

class SignInProvider with ChangeNotifier {
  bool _isLoading = false;
  SignInModel _signInModel = SignInModel();

  bool get isLoading => _isLoading;
  SignInModel get signInModel => _signInModel;

  final localDataSource = LocalDataSource();

  Future<void> signInUser(String email, String password) async {
    String apiUrl = "${ApiConstants.baseUrl}/signin";
    print("api: $apiUrl");
    print("email: $email");
    print("password: ${password.trim()}");

    _isLoading = true;
    notifyListeners();

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": password,
    });

    final responseString = response.body;
    var data = jsonDecode(responseString);
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");

    if (response.statusCode == 200) {
      _signInModel = signInModelFromJson(responseString);
      if (data['status'] == "success") {
        print("_signInModel: ${_signInModel.data!.profilePicture}");
        _signInModel = signInModelFromJson(responseString);
        await localDataSource.saveUserData(_signInModel);
        prefs = await SharedPreferences.getInstance();
        await prefs!
            .setString('profilePicture', _signInModel.data!.profilePicture);
        profilePic = prefs!.getString('profilePicture');
        print("profilePic: $profilePic");
        print("in 200 SignIn");
        print("SuccessFull");
      }
    }

    _isLoading = false;
    notifyListeners();

    print('SignIn status: ${_signInModel.status}');
  }
}
