import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/public_profile_post_model.dart';

class PublicPostProvider with ChangeNotifier {
  bool _isLoading = false;
  PublicProfilePostModel _publicProfilePostModel = PublicProfilePostModel();
  List<String> _imageUrls = [];
  List<String> _quotedImageUrls = [];

  bool get isLoading => _isLoading;
  PublicProfilePostModel get publicProfilePostModel => _publicProfilePostModel;
  List<String> get imageUrls => _imageUrls;
  List<String> get quotedImageUrls => _quotedImageUrls;

  Future<void> getPublicPost(String id) async {
    String apiUrl = "${ApiConstants.baseUrl}/fetch_user_places_public";
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
    print("fetch_user_places_public: $responseString");
    print("status Code fetch_user_places_public: ${response.statusCode}");

    if (response.statusCode == 200) {
      print("in 200 fetch_user_places_public");
      print("SuccessFull");
      _publicProfilePostModel = publicProfilePostModelFromJson(responseString);

      // Extract only the first image of each place
      _imageUrls = _publicProfilePostModel.data
              ?.map((datum) {
                if (datum.images != null && datum.images!.isNotEmpty) {
                  final url =
                      "${ApiConstants.imageBaseUrl}/${datum.images!.first.imageName ?? ''}";
                  return url.toString();
                }
                return null;
              })
              .where((url) => url != null)
              .cast<String>()
              .toList() ??
          [];

      _quotedImageUrls = _imageUrls.map((url) => '"$url"').toList();
    }

    _isLoading = false;
    notifyListeners();

    print('fetch_user_places_public status: ${_publicProfilePostModel.status}');
  }
}
