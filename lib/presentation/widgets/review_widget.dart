// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:penny_places/main.dart';
// import 'package:penny_places/presentation/providers/fetchPlacesProvider.dart';

// class ReviewWidget extends StatefulWidget {
//   final int index;

//   late FetchPlacesPostProvider fetchPlacesPostProvider;
//   ReviewWidget(FetchPlacesPostProvider fetchPlacesPostProvider,
//       {super.key, required this.index});

//   @override
//   State<ReviewWidget> createState() => _ReviewWidgetState();
// }

// class _ReviewWidgetState extends State<ReviewWidget> {
//   final TextEditingController _reviewController = TextEditingController();

//   void _addReview(BuildContext context, int index,
//       FetchPlacesPostProvider fetchPlacesPostProvider) async {
//     final reviewText = _reviewController.text;
//     const rating = 4; // You can get this dynamically based on user input
//     final userId = userID; // Replace with actual user ID
//     final placeId =
//         fetchPlacesPostProvider.fetchPlacesModel.data![index].palaceId;

//     if (reviewText.isNotEmpty) {
//       final response = await http.post(
//         Uri.parse("https://penny.eigix.net/api/review_add"),
//         headers: {'Accept': 'application/json'},
//         body: {
//           'users_customers_id': userId,
//           'place_id': placeId.toString(),
//           'rating': rating.toString(),
//           'review': reviewText,
//         },
//       );

//       final responseData = json.decode(response.body);

//       if (responseData['status'] == 'success') {
//         print(responseData['message']);
//         _reviewController.clear();
//         fetchPlacesPostProvider.refreshData(userId!);
//         Navigator.pop(context); // Close the bottom sheet
//       } else {
//         print("Failed to add review: ${responseData['message']}");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextField(
//               controller: _reviewController,
//               decoration: const InputDecoration(
//                 hintText: 'Write your review here...',
//                 border: InputBorder.none,
//               ),
//               maxLines: 5,
//             ),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.only(left: 12),
//               child: RatingBar.builder(
//                 initialRating: 0,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemSize: 24.0,
//                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 itemBuilder: (context, index) {
//                   return SvgPicture.asset(
//                     index < 3.5
//                         ? 'assets/svg/star2.svg'
//                         : 'assets/svg/star.svg',
//                   );
//                 },
//                 onRatingUpdate: (rating) {
//                   print(rating);
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _addReview(
//                     context, widget.index, widget.fetchPlacesPostProvider);
//               },
//               child: const Text('Post Review'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
