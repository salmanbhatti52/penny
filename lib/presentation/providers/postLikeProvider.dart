import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_places/core/constants/api_constants.dart';

class PostLikeProvider with ChangeNotifier {
  final Map<int, ValueNotifier<bool>> _postLikes = {}; // Track like status
  final Map<int, ValueNotifier<int>> _likeCounts = {}; // Track like counts

  // Getters for UI to use
  ValueNotifier<bool> isLiked(int postId) {
    if (!_postLikes.containsKey(postId)) {
      _postLikes[postId] = ValueNotifier<bool>(false);
    }
    return _postLikes[postId]!;
  }

  ValueNotifier<int> getLikeCount(int postId) {
    if (!_likeCounts.containsKey(postId)) {
      _likeCounts[postId] = ValueNotifier<int>(0);
    }
    return _likeCounts[postId]!;
  }

  Future<void> toggleLikeStatus(String userId, int placeId) async {
    const url = '${ApiConstants.baseUrl}/like_unlike_post';
    final payload = {
      "users_customers_id": userId,
      "penny_places_id": placeId.toString(),
    };

    // Ensure ValueNotifiers are initialized
    if (!_postLikes.containsKey(placeId)) {
      _postLikes[placeId] = ValueNotifier<bool>(false);
    }
    if (!_likeCounts.containsKey(placeId)) {
      _likeCounts[placeId] = ValueNotifier<int>(0);
    }

    final currentStatus = _postLikes[placeId]!.value;
    final newStatus = !currentStatus;
    final likeCountChange = newStatus ? 1 : -1;

    // Update local state optimistically
    _postLikes[placeId]!.value = newStatus;
    _likeCounts[placeId]!.value += likeCountChange;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          print('like status');
        }
        if (responseData['status'] != 'success') {
          throw Exception('Failed to toggle like status');
        }
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      // Revert optimistic update on error
      _postLikes[placeId]!.value = currentStatus;
      _likeCounts[placeId]!.value -= likeCountChange;
      print('Error: $e');
    }

    notifyListeners(); // Notify listeners to update UI
  }
}
