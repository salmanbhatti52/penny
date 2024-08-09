import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/data/models/add_places_model.dart';
import 'package:penny_places/presentation/widgets/custom_toast.dart';

class AddPlacesProvider with ChangeNotifier {
  bool _isLoading = false;
  AddPlacesModel _addPlacesModel = AddPlacesModel();

  bool get isLoading => _isLoading;
  AddPlacesModel get addPlacesModel => _addPlacesModel;

  final ImagePicker _picker = ImagePicker();
  final List<File> _imageFiles = [];
  final List<Map<String, String>> _imageMaps = [];

  List<File> get imageFiles => _imageFiles;

  // Main image getter and setter
  File? get mainImage => _imageFiles.isNotEmpty ? _imageFiles.first : null;
  set mainImage(File? image) {
    if (image != null && _imageFiles.contains(image)) {
      _imageFiles.remove(image);

      _imageFiles.insert(0, image);

      notifyListeners();
    }
  }
  

  Future<void> pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );

      if (pickedFiles.isEmpty) {
        return;
      }

      if (_imageFiles.length + pickedFiles.length > 5) {
        CustomToast.show('You can only select up to 5 images.', Colors.red);
        return;
      }

      // Clear previous images if necessary
      _imageFiles.clear();
      _imageMaps.clear();

      for (XFile file in pickedFiles) {
        final imageBytes = await file.readAsBytes();
        final base64Img = base64Encode(imageBytes);

        _imageFiles.add(File(file.path));

        _imageMaps.add({"image": base64Img});

        print('Added image: ${file.path}');
        print('Added _imageFiles: $_imageFiles');
        print('Base64: $base64Img');
      }

      notifyListeners();
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<void> addPlaces(
    String id,
    String placeName,
    String location,
    String placeType,
    String ratings,
    String notes,
    String postType,
    String lat,
    String lng,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
      var url = Uri.parse('${ApiConstants.baseUrl}/place_add');

      var body = {
        "users_customers_id": id,
        "place_type": placeType,
        "name": placeName,
        "location": location,
        "longitude": lat,
        "lattitude": lng,
        "visibility_flag": postType,
        "rating": ratings,
        "description": notes,
        "images": _imageMaps,
      };
      print("Request body: $body");

      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        _addPlacesModel = addPlacesModelFromJson(resBody);
        print("Response body: $resBody");
      } else {
        print('Failed to add place. Status code: ${res.statusCode}');
      }
    } catch (e) {
      print('Error adding place: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    print('addPlaces status: ${_addPlacesModel.status}');
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < _imageFiles.length) {
      _imageFiles.removeAt(index);
      _imageMaps.removeAt(index);
      if (_imageFiles.isNotEmpty) {
        mainImage = _imageFiles.first; // Update the main image if necessary
      }
      notifyListeners();
    }
  }

  void clearImages() {
    _imageFiles.clear();
    _imageMaps.clear();
    mainImage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearImages();
    super.dispose();
  }

}
