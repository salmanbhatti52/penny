import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penny_places/core/constants/constants_colors.dart';

import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/editProfileProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final String? name;
  final String? bio;
  final String? profilePicture;
  final String? profilePicUrl;
  const EditProfile(
      {super.key,
      this.name,
      this.bio,
      this.profilePicture,
      this.profilePicUrl});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  File? imagePathGallery;
  String? base64imgGallery;
  Future pickImageGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) {
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        base64imgGallery = base64.encode(imageByte);
        print("base64img $base64imgGallery");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePathGallery = imageTemporary;
          print("newImage $imagePathGallery");
          print("newImage64 $base64imgGallery");
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }
    String? base64Image;
  Future<void> convertImageToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final List<int> imageBytes = response.bodyBytes;
      final String base64 = base64Encode(imageBytes);

      setState(() {
        base64Image = base64;
        print("base64Image From Function : $base64Image");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("bio: ${widget.bio}");
    print("name: ${widget.name}");
    name.text = widget.name ?? "";
    bio.text = widget.bio ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              addHeight(33),
              Center(
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: imagePathGallery != null
                          ? Image.file(imagePathGallery!, fit: BoxFit.cover)
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://penny.eigix.net/public/${widget.profilePicUrl}"),
                                  fit: BoxFit.cover,
                                ),
                                shape: const OvalBorder(),
                              ),
                            ), // Empty container as a fallback
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImageGallery();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 80,
                        left: 90,
                      ),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: ConstantsColors.blueColor,
                        border: Border.all(width: 1, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/cam2.svg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ]),
              ),
              addHeight(8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 19),
                      child: Text(
                        'Name',
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
                                'assets/svg/user.svg',
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
                            hintText: 'Name',
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
              addHeight(20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 19),
                      child: Text(
                        'Profile Bio',
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
                          controller: bio,
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
                            hintText: 'Adventure Lover exploring...',
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
              addHeight(38),
              Consumer<EditProfileProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ConstantsColors.blueColor),
                        )
                      : GestureDetector(
                          onTap: () async {
                            prefs = await SharedPreferences.getInstance();
                            userID = prefs?.getString('userID');
                            print("Pressed");
                            if (name.text.isEmpty && bio.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFFF65734),
                                  content: Text(
                                    'Please Enter Email and Password',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              await provider.editProfile(
                                  userID!,
                                  name.text,
                                  bio.text,
                                  base64imgGallery ?? widget.profilePicture);
                              if (provider.editProfileModel.status ==
                                  "success") {
                                prefs = await SharedPreferences.getInstance();
                                await prefs!.setString(
                                    'profilePicture',
                                    provider
                                        .editProfileModel.data!.profilePicture);
                                print("successful");
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xFFF65734),
                                    content: Text(
                                      provider.editProfileModel.message
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 197,
                            height: 48,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: ConstantsColors.blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Save Changes',
                                        style: GoogleFonts.poppins(
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
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
