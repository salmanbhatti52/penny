import 'package:flutter/material.dart';

class PublicPostSection extends StatefulWidget {
  const PublicPostSection({super.key});

  @override
  State<PublicPostSection> createState() => _PublicPostSectionState();
}

class _PublicPostSectionState extends State<PublicPostSection> {
  // Example list of image URLs - replace with your own data source
  final List<String> images = [
    'https://images.pexels.com/photos/26088418/pexels-photo-26088418/free-photo-of-a-woman-in-a-black-dress-and-sunglasses.jpeg',
    'https://images.pexels.com/photos/2884866/pexels-photo-2884866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    "https://images.pexels.com/photos/707612/pexels-photo-707612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/372490/pexels-photo-372490.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3214975/pexels-photo-3214975.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    // Add more image URLs
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 2, // Horizontal space between items
        mainAxisSpacing: 2, // Vertical space between items
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.network(images[index], fit: BoxFit.cover);
      },
    );
  }
}
