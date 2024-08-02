import 'dart:convert';
import 'dart:io';
import 'package:penny_places/core/constants/constants_colors.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/widgets/custom_toast.dart';

class PrivatePostScreen extends StatefulWidget {
  const PrivatePostScreen({super.key});

  @override
  State<PrivatePostScreen> createState() => _PrivatePostScreenState();
}

class _PrivatePostScreenState extends State<PrivatePostScreen> {
  String? selectedValue;
  File? imagePathGallery;
  String? base64imgGallery;
  List<File> imagePathGalleryList = [];
  List<String> base64imgGalleryList = [];
  File? mainImage;
  Future pickImageGallery() async {
    if (imagePathGalleryList.length >= 5) {
      CustomToast.show('You can only select up to 5 images.', Colors.red);

      return;
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
        // Handle the case when no image is selected
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        String base64img = base64.encode(imageByte);
        print("base64img $base64img");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGalleryList.add(imageTemporary);
          base64imgGalleryList.add(base64img);
          mainImage ??= imageTemporary;
          print("newImageList $imagePathGalleryList");
          print("newImage64List $base64imgGalleryList");
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  final List<String> items = [
    'Restaurant',
    'Bar',
    'Hotel',
    'Cafe',
    'Cinema',
  ];
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            addHeight(34),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 19),
                    child: Text(
                      'Name of Place',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  addHeight(8),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              color: Color(0xFF000000), fontSize: 16),
                          cursorColor: const Color(0xFF000000),
                          controller: name,
                          // keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            // prefix: Container(width: 16),
                            filled: true, // Add this line
                            fillColor: const Color(0xFFF4F4F4),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/svg/nameP.svg',
                                width: 23,
                                height: 23,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFEEEEEE)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // labelText: 'Email',
                            hintText: 'Enter Place Name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color:
                                      Color(0xFFEEEEEE)), // change border color
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFF7F8C8D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addHeight(18),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 19),
                    child: Text(
                      'Location of Place',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  addHeight(8),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              color: Color(0xFF000000), fontSize: 16),
                          cursorColor: const Color(0xFF000000),
                          controller: location,
                          // keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            // prefix: Container(width: 16),
                            filled: true, // Add this line
                            fillColor: const Color(0xFFF4F4F4),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/svg/location.svg',
                                width: 23,
                                height: 23,
                                color: ConstantsColors.blueColor,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFEEEEEE)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // labelText: 'Email',
                            hintText: 'Enter Location',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color:
                                      Color(0xFFEEEEEE)), // change border color
                            ),
                            hintStyle: const TextStyle(
                              color: Color(0xFF7F8C8D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  addHeight(18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 19),
                        child: Text(
                          'Place Type',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      addHeight(8),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: DropdownButtonFormField2<String>(
                            value: selectedValue,
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          color: Color(0xFF7F8C8D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                print("selectedValue: $selectedValue");
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                                height: 51,
                                width: 160,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFF3F3F3),
                                  ),
                                  // color: Colors.redAccent,
                                ),
                                elevation: 0,
                                overlayColor: const WidgetStatePropertyAll(
                                    Color(0xFFF4F4F4))),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: ConstantsColors.blueColor,
                              ),
                              iconSize: 30,
                            ),

                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF4F4F4),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color(0xFFEEEEEE))),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              overlayColor:
                                  WidgetStatePropertyAll(Color(0xFFEEEEEE)),
                            ),
                            isExpanded: true,
                            isDense: true,
                            // Reduce vertical padding
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFF4F4F4),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFF4F4F4)),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              // hintText: 'Select Place Type',

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFF4F4F4)),
                              ),
                              hintStyle: const TextStyle(
                                color: Color(0xFF7F8C8D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            hint: const Text(
                              'Select Place Type',
                              style: TextStyle(
                                color: Color(0xFF7F8C8D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  addHeight(18),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8, right: 6),
                              child: Text(
                                'Photo of Place',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await pickImageGallery();
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            await pickImageGallery();
                          },
                          child: Container(
                            width: 350,
                            height: 173,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: mainImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      mainImage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : Center(
                                    child: TextButton(
                                      onPressed: () async {
                                        await pickImageGallery();
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/gallery.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Browse Image',
                                            style: TextStyle(
                                              color: Color(0xFFAEAEAE),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        if (imagePathGalleryList.isNotEmpty)
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imagePathGalleryList.length,
                              itemBuilder: (context, index) {
                                final image = imagePathGalleryList[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            mainImage = image;
                                          });
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 75,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: FileImage(image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -8,
                                        child: IconButton(
                                          icon: const Icon(Icons.delete,
                                              size: 20, color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              imagePathGalleryList
                                                  .removeAt(index);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  addHeight(18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 19),
                        child: Text(
                          'Rate this place',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      addHeight(8),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: RatingBar.builder(
                          initialRating: _currentRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24.0, // Adjust the size of the stars
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, index) {
                            return SvgPicture.asset(
                              index < _currentRating
                                  ? 'assets/svg/star2.svg'
                                  : 'assets/svg/star.svg',
                            );
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              _currentRating = rating;
                            });
                            print(rating); // Print the current rating
                          },
                        ),
                      ),
                    ],
                  ),
                  addHeight(18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 19),
                          child: Text(
                            'Extra Notes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          )),
                      addHeight(8),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              maxLength: 500,
                              minLines: 5, // Minimum lines when not focused
                              maxLines: 6,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(
                                  color: Color(0xFF000000), fontSize: 16),
                              cursorColor: const Color(0xFF000000),
                              controller: description,
                              // keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefix: Container(width: 16),
                                filled: true, // Add this line
                                fillColor: const Color(0xFFF4F4F4),
                                // prefixIcon: Padding(
                                //   padding: const EdgeInsets.all(12),
                                //   child: SvgPicture.asset(
                                //     'assets/svg/location.svg',
                                //     width: 23,
                                //     height: 23,
                                //     color: ConstantsColors.blueColor,
                                //   ),
                                // ),

                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xFFEEEEEE)),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                // labelText: 'Email',
                                hintText: 'Write Extra Notes Here..',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(
                                          0xFFEEEEEE)), // change border color
                                ),
                                hintStyle: const TextStyle(
                                  color: Color(0xFF7F8C8D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  addHeight(38),
                  Center(
                    child: GestureDetector(
                      child: Container(
                        width: 197,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 43, vertical: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: ConstantsColors.blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Post',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _currentRating = 3.5;
}