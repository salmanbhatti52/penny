import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/get_profile_model.dart';
import 'package:penny_places/data/models/postPlaceCount.dart';

class PostPlaceCountProvider with ChangeNotifier {
  bool _isLoading = false;
  PostPlaceCountModel _postPlaceCountModel = PostPlaceCountModel();
  bool get isLoading => _isLoading;
  PostPlaceCountModel get postPlaceCountModel => _postPlaceCountModel;
  Future<void> getPostPlaceCount(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/posts_reviwes_count";
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
    print("posts_reviwes_count: $responseString");
    print("status Code posts_reviwes_count: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 get_profile");
      print("SuccessFull");
      _postPlaceCountModel = postPlaceCountModelFromJson(responseString);
    }

    _isLoading = false;
    notifyListeners();

    print('posts_reviwes_count status: ${_postPlaceCountModel.status}');
  }
}
