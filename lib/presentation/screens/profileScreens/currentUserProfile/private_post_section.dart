import 'package:flutter/material.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/privatePostProvider.dart';
import 'package:penny_places/presentation/screens/profileScreens/currentUserProfile/open_post_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class PrivatePostSection extends StatefulWidget {
  const PrivatePostSection({super.key});

  @override
  State<PrivatePostSection> createState() => _PrivatePostSectionState();
}

class _PrivatePostSectionState extends State<PrivatePostSection> {
  loadData() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    debugPrint("userID: $userID");

    Provider.of<PrivatePostProvider>(context, listen: false)
        .getPrivatePost(userID!);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrivatePostProvider>(
      builder: (context, publicPostProvider, child) {
        if (publicPostProvider.isLoading) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 2, // Horizontal space between items
              mainAxisSpacing: 2, // Vertical space between items
            ),
            itemCount: 9, // Number of shimmer placeholders
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Container(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                ),
              );
            },
          );
        }

        final images = publicPostProvider.imageUrls;
        if (images.isEmpty) {
          return const Center(
            child: Text('Wow Such Empty'),
          );
        }

        print("images: $images");
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 2, // Horizontal space between items
            mainAxisSpacing: 2, // Vertical space between items
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final reversedIndex = images.length - 1 - index;
            final imageUrl = images[reversedIndex];
            final reversedIndex1 =
                publicPostProvider.privateProfilePostModel.data!.length -
                    1 -
                    index;
            final index1 = publicPostProvider
                .privateProfilePostModel.data![reversedIndex1].palaceId;
            return GestureDetector(
              onTap: () {
                debugPrint("index: $index1");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpenPostScreen(
                      index: index1,
                    ),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          },
        );
      },
    );
  }
}
