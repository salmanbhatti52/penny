import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import "package:google_maps_webservice_ex/places.dart";
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/addPlacesProvider.dart';
import 'package:penny_places/presentation/providers/placeTypeProvider.dart';
import 'package:penny_places/presentation/screens/main_screen.dart';
import 'package:penny_places/presentation/widgets/custom_toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class PublicPostScreen extends StatefulWidget {
  const PublicPostScreen({super.key});

  @override
  State<PublicPostScreen> createState() => _PublicPostScreenState();
}

class _PublicPostScreenState extends State<PublicPostScreen> {
  String? selectedPlaceId;
  File? imagePathGallery;
  String? base64imgGallery;
  loadData() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    userName = prefs?.getString('userName');
    debugPrint("userID: $userID");
    debugPrint("userName: $userName");
    Provider.of<AddPlacesProvider>(context, listen: false).clearImages();
    Provider.of<PlaceTypeProvider>(context, listen: false)
        .getPlaceType(userID!);
  }

  String destinationLat = "1234";
  String destinationLng = "1234";
  List<PlacesSearchResult> destinationPredictions = [];
  var places;
  int apiHitCount = 0;
  Timer? _debounceTimer;
  Future<void> searchDestinationPlaces(String input) async {
    if (input.isNotEmpty) {
      // Cancel previous debounce timer
      if (_debounceTimer != null) {
        _debounceTimer!.cancel();
      }

      // Start a new debounce timer
      _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
        final response = await places.searchByText(input);
        apiHitCount++; // Increment API hit count

        // Track analytics event
        // await googleAnalytics(input);

        if (response.isOkay) {
          setState(() {
            destinationPredictions = response.results;
          });
        }
      });
    }
  }

  // AIzaSyA1kEvCbj9i4-ez8d8KEvEfUuoDzFyjvEc
  String? mapsKey = "";
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    super.initState();
    places = GoogleMapsPlaces(apiKey: mapsKey);
    print("placesssssssssssssssssssssssssssssss: $places");
    loadData();
  }

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
                        child: Stack(
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                  color: Color(0xFF000000), fontSize: 16),
                              cursorColor: const Color(0xFF000000),
                              controller: location,
                              onChanged: (value) {
                                searchDestinationPlaces(value);
                              },
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
                            if (destinationPredictions.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 48),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(
                                        0xFFF4F4F4), // Match the text field's fill color
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.999,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    itemCount: destinationPredictions.length,
                                    itemBuilder: (context, index) {
                                      final prediction =
                                          destinationPredictions[index];
                                      return ListTile(
                                        title: Text(prediction.name),
                                        subtitle: Text(
                                            prediction.formattedAddress ?? ''),
                                        onTap: () {
                                          location.text =
                                              prediction.formattedAddress!;
                                          final double lat =
                                              prediction.geometry!.location.lat;
                                          final double lng =
                                              prediction.geometry!.location.lng;
                                          destinationLat = lat.toString();
                                          destinationLng = lng.toString();
                                          setState(() {
                                            destinationPredictions.clear();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            debugPrint(
                                                "destinationLat: $destinationLat");
                                            debugPrint(
                                                "destinationLng: $destinationLng");
                                            debugPrint(
                                                "destinationLocation: ${prediction.formattedAddress}");
                                          });
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Color(
                                            0xFF7F8C8D), // Match the text field's hint color
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  addHeight(18),
                  Consumer<PlaceTypeProvider>(
                    builder: (context, placeTypeProvider, child) {
                      // Use placeTypeProvider here
                      return Column(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              if (placeTypeProvider.isLoading)
                                Center(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.0),
                                      child: Container(
                                        height: 48,
                                        width: 320,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: DropdownButtonFormField2<String>(
                                    value: selectedPlaceId,
                                    items: placeTypeProvider
                                        .placesTypeModel.data
                                        ?.map((datum) =>
                                            DropdownMenuItem<String>(
                                              value:
                                                  datum.placesTypeId.toString(),
                                              child: Text(
                                                datum.place,
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
                                        selectedPlaceId = value;
                                        print(
                                            "selectedPlace ID: $selectedPlaceId");
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                        height: 51,
                                        width: 160,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: const Color(0xFFF3F3F3),
                                          ),
                                        ),
                                        elevation: 0,
                                        overlayColor:
                                            const WidgetStatePropertyAll(
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: const Color(0xFFEEEEEE))),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      overlayColor: WidgetStatePropertyAll(
                                          Color(0xFFEEEEEE)),
                                    ),
                                    isExpanded: true,
                                    isDense: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: const Color(0xFFF4F4F4),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xFFF4F4F4)),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
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
                                  ),
                                ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ); // Replace with actual widget
                    },
                  ),

                  addHeight(18),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Consumer<AddPlacesProvider>(
                      builder: (context, addPlacesProvider, child) {
                        return Column(
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
                                    await addPlacesProvider.pickImages();
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
                                await addPlacesProvider.pickImages();
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
                                child: addPlacesProvider.imageFiles.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(
                                          addPlacesProvider.mainImage!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      )
                                    : Center(
                                        child: TextButton(
                                          onPressed: () async {
                                            await addPlacesProvider
                                                .pickImages();
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
                            if (addPlacesProvider.imageFiles.isNotEmpty)
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      addPlacesProvider.imageFiles.length,
                                  itemBuilder: (context, index) {
                                    final image =
                                        addPlacesProvider.imageFiles[index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              addPlacesProvider.mainImage =
                                                  image;
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
                                                addPlacesProvider
                                                    .removeImageAt(index);
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
                        );
                      },
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
                          initialRating: currentRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24.0, // Adjust the size of the stars
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, index) {
                            return SvgPicture.asset(
                              index < currentRating
                                  ? 'assets/svg/star2.svg'
                                  : 'assets/svg/star.svg',
                            );
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              currentRating = rating;
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
                  Consumer<AddPlacesProvider>(
                    builder: (context, provider, child) {
                      return provider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ConstantsColors.blueColor),
                              ),
                            )
                          : Center(
                              child: GestureDetector(
                                onTap: () async {
                                  print("Pressed");
                                  var data = {
                                    userID!,
                                    name.text,
                                    location.text,
                                    selectedPlaceId.toString(),
                                    currentRating.toString(),
                                    description.text,
                                    "public",
                                    destinationLat.toString(),
                                    destinationLng.toString(),
                                  };
                                  print(data);
                                  if (name.text.isEmpty &&
                                      location.text.isEmpty &&
                                      selectedPlaceId == null &&
                                      description.text.isEmpty) {
                                    CustomToast.show(
                                        "All Fields are Required", Colors.red);
                                  } else {
                                    await provider.addPlaces(
                                      userID!,
                                      name.text,
                                      location.text,
                                      selectedPlaceId.toString(),
                                      currentRating.toString(),
                                      description.text,
                                      "public",
                                      destinationLat.toString(),
                                      destinationLng.toString(),
                                      // newBase64imgList,
                                    );
                                    if (provider.addPlacesModel.status ==
                                        "success") {
                                      CustomToast.show(
                                          "Post added successfully",
                                          Colors.green.withOpacity(0.8));
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return const MainScreen(index: 0);
                                          },
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              const Color(0xFFF65734),
                                          content: Text(
                                            provider.addPlacesModel.message
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Post',
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
                              ),
                            );
                    },
                  ),

                  // Center(
                  //   child: GestureDetector(
                  //     child: Container(
                  //       width: 197,
                  //       height: 48,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 43, vertical: 10),
                  //       clipBehavior: Clip.antiAlias,
                  //       decoration: ShapeDecoration(
                  //         color: ConstantsColors.blueColor,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(100),
                  //         ),
                  //       ),
                  //       child: const Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           SizedBox(
                  //             width: double.infinity,
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   'Post',
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     height: 0,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double currentRating = 3.5;
}
