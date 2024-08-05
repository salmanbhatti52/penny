import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/delete_account_model.dart';

class DeleteAccountProvider with ChangeNotifier {
  bool _isLoading = false;
  DeleteAccountModel _deleteAccountModel = DeleteAccountModel();

  bool get isLoading => _isLoading;
  DeleteAccountModel get deleteAccountModel => _deleteAccountModel;

  Future<void> deleteAccount(String email) async {
    String apiUrl = "${ApiConstants.baseUrl}/delete_account";
    print("api: $apiUrl");

    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "user_email": email,
    });

    final responseString = response.body;
    print("delete_account: $responseString");
    print("status Code delete_account: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 delete_account");
      print("SuccessFull");
      _deleteAccountModel = deleteAccountModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('delete_account status: ${_deleteAccountModel.status}');
  }

}
