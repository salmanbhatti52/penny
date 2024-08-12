import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penny_places/data/models/fetch_places_model.dart';
import 'package:penny_places/presentation/providers/postLikeProvider.dart';
import 'package:penny_places/presentation/providers/reportPlaceProvider.dart';
import 'package:penny_places/presentation/screens/home/photo/full_photo_view.dart';
import 'package:penny_places/presentation/screens/main_screen.dart';
import 'package:penny_places/presentation/screens/profileScreens/otherUserProfile/other_user_profile.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/api_constants.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/fetchPlacesProvider.dart';
import 'package:penny_places/presentation/widgets/expandable_text_widget.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  late PostLikeProvider postLikeProvider;
  loadData() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs?.getString('userID');
    debugPrint("userID: $userID");

    Provider.of<FetchPlacesPostProvider>(context, listen: false)
        .getAllPost(userID!);
  }

  @override
  void initState() {
    super.initState();
    loadData();
    postLikeProvider = PostLikeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchPlacesPostProvider>(
        builder: (context, getAllPostProvider, child) {
      final data = getAllPostProvider.fetchPlacesModel.data;
      List<Datum> data1 = getAllPostProvider.filteredPlaces;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // Add this line
          title: Text(
            'Home',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/notification.svg',
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF000000), fontSize: 16),
                    cursorColor: const Color(0xFF000000),
                    controller: search,
                    onChanged: (value) {
                      // Update the filtered list in provider when search query changes
                      getAllPostProvider.filterPlaces(value);
                    },
                    decoration: InputDecoration(
                      prefix: Container(width: 16),
                      filled: true,
                      fillColor: const Color(0xFFF4F4F4),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/svg/search.svg',
                          width: 23,
                          height: 23,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Type here to Search...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFEEEEEE)),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
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
            addHeight(30),
            Expanded(
              child: getAllPostProvider.isFirstLoad
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = data?[data.length - 1 - index];
                            print("item: ${item!.images!.length}");
                            print("User Names: ${item.user?.username}");
                            // print("Review Text: ${item.reviews![index].review}");
                            // print("Review Rating: ${item.reviews![index].rating}");
                            // print(
                            //     "Review likesCount: ${item.reviews![index].likesCount}");
                            // print(
                            //     "Reviewer user name: ${item.reviews![index].reviewUserName}");
                            // print(
                            //     "Reviewe like by me or not ${item.reviews![index].likedByMe}");

                            return Container(
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  width: 47,
                                                  height: 47,
                                                  imageUrl:
                                                      "${ApiConstants.imageBaseUrl}/${item.user?.profilePicture}",
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, bottom: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.user?.username ??
                                                          'Leo Nardo',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${timeago.format(
                                                        DateTime.parse(item
                                                                .dateAdded ??
                                                            DateTime.now()
                                                                .toString()),
                                                        locale: 'en_short',
                                                      )} ago",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF7F8C8D),
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: SvgPicture.asset(
                                              'assets/svg/more.svg',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  addHeight(10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/building.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              item.placeName ?? '',
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        addHeight(6),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/location.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              "${item.placeLocation}",
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                        addHeight(6),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/book.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              "${item.placeTypeName}",
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  addHeight(10),
                                  SizedBox(
                                    height:
                                        250, // Give a fixed height to the PageView.builder
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          controller: PageController(
                                            initialPage: context
                                                .read<FetchPlacesPostProvider>()
                                                .currentPage,
                                          ),
                                          itemCount: item.images?.length ?? 0,
                                          onPageChanged: (index) {
                                            context
                                                .read<FetchPlacesPostProvider>()
                                                .currentPage = index;
                                          },
                                          itemBuilder: (context, index) {
                                            final image = item.images?[index];
                                            return InkWell(
                                              onTap: () {
                                                print("Image tapped");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullScreenImageGallery(
                                                      imageUrls: item.images!
                                                          .map((e) =>
                                                              "${ApiConstants.imageBaseUrl}/${e.imageName}")
                                                          .toList(),
                                                      initialIndex: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                width: 390,
                                                height: 213,
                                                imageUrl:
                                                    "${ApiConstants.imageBaseUrl}/${image?.imageName}",
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                        if ((item.images?.length ?? 0) > 1)
                                          Positioned(
                                            bottom: 8,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Consumer<
                                                  FetchPlacesPostProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return SmoothPageIndicator(
                                                    controller: PageController(
                                                      initialPage:
                                                          provider.currentPage,
                                                    ),
                                                    count: item.images!.length,
                                                    effect: WormEffect(
                                                      dotWidth: 6.0,
                                                      dotHeight: 6.0,
                                                      spacing: 5.0,
                                                      dotColor: Colors.white
                                                          .withOpacity(0.5),
                                                      activeDotColor:
                                                          ConstantsColors
                                                              .blueColor,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, right: 5),
                                    child: ExpandableTextWidget(
                                      text: "${item.placeDescription}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, top: 4, right: 8),
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.tryParse(
                                                  item.placeRating ?? '0.0') ??
                                              0.0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize:
                                              24.0, // Adjust the size of the stars
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, index) {
                                            return index <
                                                    (double.tryParse(
                                                            item.placeRating ??
                                                                "0.0") ??
                                                        0.0)
                                                ? SvgPicture.asset(
                                                    'assets/svg/star2.svg') // Filled star image
                                                : SvgPicture.asset(
                                                    'assets/svg/star.svg'); // Empty star image
                                          },
                                          ignoreGestures:
                                              true, // Make the RatingBar static and non-interactive
                                          onRatingUpdate: (rating) {
                                            // No need to update the rating since it's static
                                          },
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Add some space between the stars and the rating text
                                        Text(
                                          '(${item.placeRating})',
                                          style: GoogleFonts.poppins(
                                            color: ConstantsColors.blueColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ), // Display the rating result dynamically
                                        const Spacer(),
                                        Consumer<PostLikeProvider>(
                                          builder: (context, postLikeProvider,
                                              child) {
                                            return ValueListenableBuilder<int>(
                                              valueListenable: postLikeProvider
                                                  .getLikeCount(item.palaceId!),
                                              builder:
                                                  (context, likeCount, child) {
                                                return Text(
                                                  '${item.likeCount}',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 4),
                                        Consumer<PostLikeProvider>(
                                          builder: (context, postLikeProvider,
                                              child) {
                                            return LikeButton(
                                              size: 28.0,
                                              circleColor: const CircleColor(
                                                start: Color(
                                                    0xffff0000), // Red color
                                                end: Color(
                                                    0xffcc0000), // Darker red color
                                              ),
                                              bubblesColor: const BubblesColor(
                                                dotPrimaryColor: Color(
                                                    0xffff3333), // Lighter red color
                                                dotSecondaryColor: Color(
                                                    0xffcc0000), // Darker red color
                                              ),
                                              isLiked: item.likedByMe!,
                                              likeBuilder: (bool isLiked) {
                                                return Icon(
                                                  Icons.favorite,
                                                  color: isLiked
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  size: 28.0,
                                                );
                                              },
                                              onTap: (bool isLiked) async {
                                                // Toggle like status
                                                await postLikeProvider
                                                    .toggleLikeStatus(userID!,
                                                        item.palaceId!);

                                                // Refresh the feed to get updated like counts
                                                await Provider.of<
                                                            FetchPlacesPostProvider>(
                                                        context,
                                                        listen: false)
                                                    .getAllPost(userID!);

                                                return !isLiked;
                                              },
                                            );
                                          },
                                        ) // Pass the actual userId and placeId
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 5, top: 4),
                                    child: Text(
                                      'View all Reviews',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF7F8C8D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            width: 28,
                                            height: 28,
                                            imageUrl:
                                                "${ApiConstants.imageBaseUrl}/$profilePic",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        addWidth(4),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: [
                                        //     IconButton(
                                        //       icon: const Icon(Icons.comment),
                                        //       onPressed: () {
                                        //         _showBottomSheet(context, index,
                                        //             getAllPostProvider);
                                        //       },
                                        //     ),
                                        //     Text(item.reviews?.length.toString() ??
                                        //         '0'),
                                        //   ],
                                        // )
                                        GestureDetector(
                                          onTap: () {
                                            _showBottomSheet(context, index,
                                                getAllPostProvider);
                                          },
                                          child: Text(
                                            'Write a review...',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF7F8C8D),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 20,
                                    thickness: 0.5,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  : RefreshIndicator(
                      onRefresh: () => getAllPostProvider.refreshData(userID!),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: search.text.isNotEmpty
                              ? data1.length ?? 0
                              : data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = data?[data.length - 1 - index];
                            print("item: ${item!.images!.length}");
                            print("User Names: ${item.user?.username}");
                            // print("Review Text: ${item.reviews![index].review}");
                            // print("Review Rating: ${item.reviews![index].rating}");
                            // print(
                            //     "Review likesCount: ${item.reviews![index].likesCount}");
                            // print(
                            //     "Reviewer user name: ${item.reviews![index].reviewUserName}");
                            // print(
                            //     "Reviewe like by me or not ${item.reviews![index].likedByMe}");

                            return Container(
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (item.user?.userId
                                                      .toString() !=
                                                  userID) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherUserProfile(
                                                      userID: item.user?.userId
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainScreen(
                                                      index:
                                                          3, // Navigate to the Profile screen in the NavBar
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    width: 47,
                                                    height: 47,
                                                    imageUrl:
                                                        "${ApiConstants.imageBaseUrl}/${item.user?.profilePicture}",
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[100]!,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, bottom: 5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.user?.username ??
                                                            'Leo Nardo',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${timeago.format(
                                                          DateTime.parse(item
                                                                  .dateAdded ??
                                                              DateTime.now()
                                                                  .toString()),
                                                          locale: 'en_short',
                                                        )} ago",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color(
                                                              0xFF7F8C8D),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: PopupMenuButton<String>(
                                              onSelected:
                                                  (String result) async {
                                                if (result == 'report') {
                                                  // Call the reportPlace method from the provider
                                                  final reportProvider = Provider
                                                      .of<ReportPlacesProvider>(
                                                          context,
                                                          listen: false);
                                                  reportProvider.reportPlace(
                                                      userID!,
                                                      '${item.palaceId}'); // Replace with actual userId and pennyId
                                                  await Provider.of<
                                                              FetchPlacesPostProvider>(
                                                          context,
                                                          listen: false)
                                                      .getAllPost(userID!);
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                PopupMenuItem<String>(
                                                  value: 'report',
                                                  child: Container(
                                                    height:
                                                        40, // Adjust the height as needed
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Rounded corners
                                                    ),
                                                    child: const Row(
                                                      children: [
                                                        Text('Report'),
                                                        SizedBox(width: 8),
                                                        Icon(Icons.report,
                                                            color: Colors.red),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              color: Colors
                                                  .white, // Set the background color of the popup menu to white
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Rounded corners for the popup menu
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/svg/more.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  addHeight(10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/building.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              item.placeName ?? '',
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        addHeight(6),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/location.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              "${item.placeLocation}",
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                        addHeight(6),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/book.svg',
                                            ),
                                            addWidth(4),
                                            Text(
                                              "${item.placeTypeName}",
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF7F8C8D),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  addHeight(10),
                                  SizedBox(
                                    height: 250,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          controller: PageController(
                                            initialPage: context
                                                .read<FetchPlacesPostProvider>()
                                                .currentPage,
                                          ),
                                          itemCount: item.images?.length ?? 0,
                                          onPageChanged: (index) {
                                            context
                                                .read<FetchPlacesPostProvider>()
                                                .currentPage = index;
                                          },
                                          itemBuilder: (context, index) {
                                            final image = item.images?[index];
                                            return GestureDetector(
                                              onTap: () {
                                                print("Image tapped");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullScreenImageGallery(
                                                      imageUrls: item.images!
                                                          .map((e) =>
                                                              "${ApiConstants.imageBaseUrl}/${e.imageName}")
                                                          .toList(),
                                                      initialIndex: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                // Added Container
                                                child: CachedNetworkImage(
                                                  width: 390,
                                                  height: 213,
                                                  imageUrl:
                                                      "${ApiConstants.imageBaseUrl}/${image?.imageName}",
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        width: 390,
                                                        height: 213,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        if ((item.images?.length ?? 0) > 1)
                                          Positioned(
                                            bottom: 8,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Consumer<
                                                  FetchPlacesPostProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return SmoothPageIndicator(
                                                    controller: PageController(
                                                      initialPage:
                                                          provider.currentPage,
                                                    ),
                                                    count: item.images!.length,
                                                    effect: WormEffect(
                                                      dotWidth: 6.0,
                                                      dotHeight: 6.0,
                                                      spacing: 5.0,
                                                      dotColor: Colors.white
                                                          .withOpacity(0.5),
                                                      activeDotColor:
                                                          ConstantsColors
                                                              .blueColor,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, right: 5),
                                    child: ExpandableTextWidget(
                                      text: "${item.placeDescription}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, top: 4, right: 8),
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.tryParse(
                                                  item.placeRating ?? '0.0') ??
                                              0.0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize:
                                              24.0, // Adjust the size of the stars
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, index) {
                                            return index <
                                                    (double.tryParse(
                                                            item.placeRating ??
                                                                "0.0") ??
                                                        0.0)
                                                ? SvgPicture.asset(
                                                    'assets/svg/star2.svg') // Filled star image
                                                : SvgPicture.asset(
                                                    'assets/svg/star.svg'); // Empty star image
                                          },
                                          ignoreGestures:
                                              true, // Make the RatingBar static and non-interactive
                                          onRatingUpdate: (rating) {
                                            // No need to update the rating since it's static
                                          },
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Add some space between the stars and the rating text
                                        Text(
                                          '(${item.placeRating})',
                                          style: GoogleFonts.poppins(
                                            color: ConstantsColors.blueColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ), // Display the rating result dynamically
                                        const Spacer(),
                                        Consumer<PostLikeProvider>(
                                          builder: (context, postLikeProvider,
                                              child) {
                                            return ValueListenableBuilder<int>(
                                              valueListenable: postLikeProvider
                                                  .getLikeCount(item.palaceId!),
                                              builder:
                                                  (context, likeCount, child) {
                                                return Text(
                                                  '${item.likeCount}',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 4),
                                        Consumer<PostLikeProvider>(
                                          builder: (context, postLikeProvider,
                                              child) {
                                            return LikeButton(
                                              size: 28.0,
                                              circleColor: const CircleColor(
                                                start: Color(
                                                    0xffff0000), // Red color
                                                end: Color(
                                                    0xffcc0000), // Darker red color
                                              ),
                                              bubblesColor: const BubblesColor(
                                                dotPrimaryColor: Color(
                                                    0xffff3333), // Lighter red color
                                                dotSecondaryColor: Color(
                                                    0xffcc0000), // Darker red color
                                              ),
                                              isLiked: item.likedByMe!,
                                              likeBuilder: (bool isLiked) {
                                                return Icon(
                                                  Icons.favorite,
                                                  color: isLiked
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  size: 28.0,
                                                );
                                              },
                                              onTap: (bool isLiked) async {
                                                // Toggle like status
                                                await postLikeProvider
                                                    .toggleLikeStatus(userID!,
                                                        item.palaceId!);

                                                // Refresh the feed to get updated like counts
                                                await Provider.of<
                                                            FetchPlacesPostProvider>(
                                                        context,
                                                        listen: false)
                                                    .getAllPost(userID!);

                                                return !isLiked;
                                              },
                                            );
                                          },
                                        ) // Pass the actual userId and placeId
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 5, top: 4),
                                    child: Text(
                                      'View all Reviews',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF7F8C8D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            width: 28,
                                            height: 28,
                                            imageUrl:
                                                "${ApiConstants.imageBaseUrl}/$profilePic",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        addWidth(4),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: [
                                        //     IconButton(
                                        //       icon: const Icon(Icons.comment),
                                        //       onPressed: () {
                                        //         _showBottomSheet(context, index,
                                        //             getAllPostProvider);
                                        //       },
                                        //     ),
                                        //     Text(item.reviews?.length.toString() ??
                                        //         '0'),
                                        //   ],
                                        // )
                                        GestureDetector(
                                          onTap: () {
                                            _showBottomSheet(context, index,
                                                getAllPostProvider);
                                          },
                                          child: Text(
                                            'Write a review...',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF7F8C8D),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 20,
                                    thickness: 0.5,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      );
    });
  }

  void _showBottomSheet(BuildContext context, int index,
      FetchPlacesPostProvider fetchPlacesPostProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Display comments
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: fetchPlacesPostProvider.fetchPlacesModel.data![index]
                                .reviews?.isEmpty ??
                            true
                        ? const Center(
                            child: Text(
                              'Wow Such Empty',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: fetchPlacesPostProvider.fetchPlacesModel
                                    .data![index].reviews?.length ??
                                0,
                            itemBuilder: (context, reviewIndex) {
                              final review = fetchPlacesPostProvider
                                  .fetchPlacesModel
                                  .data![index]
                                  .reviews![reviewIndex];
                              return _buildComment(
                                review.review ?? '',
                                review.reviewUserName ?? '',
                                review.likesCount ?? 0,
                                review.reviewUserProfilePicture ?? '',
                                review.likedByMe ?? false,
                                double.tryParse(review.rating.toString()) ?? 0,
                                fetchPlacesPostProvider
                                        .fetchPlacesModel.data![index].palaceId
                                        .toString() ??
                                    '',
                                review.reviewId.toString() ?? '',
                                fetchPlacesPostProvider,
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          width: 38,
                          height: 38,
                          imageUrl: "${ApiConstants.imageBaseUrl}/$profilePic",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context); // Close the current bottom sheet

                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0)),
                                ),
                                builder: (BuildContext bc) {
                                  return _showReviewBottomSheet(
                                      context, index, fetchPlacesPostProvider);
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              'Add a Review...',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          _addReview(
                              context, index, 2.4, fetchPlacesPostProvider);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double? ratings1;
  Widget _showReviewBottomSheet(BuildContext context, int index,
      FetchPlacesPostProvider fetchPlacesPostProvider) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Write a review',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  addHeight(8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLength: 500,
                          minLines: 5, // Minimum lines when not focused
                          maxLines: 6,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                              color: Color(0xFF000000), fontSize: 16),
                          cursorColor: const Color(0xFF000000),
                          controller: _reviewController,
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
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 350,
                    child: Text(
                      'Rating this Place',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) {
                      return SvgPicture.asset(
                        index < 5
                            ? 'assets/svg/star2.svg'
                            : 'assets/svg/star.svg',
                      );
                    },
                    onRatingUpdate: (rating) {
                      ratings1 = rating;
                      print(rating);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _addReview(
                        context, index, ratings1!, fetchPlacesPostProvider);
                  },
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
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
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
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     _addReview(context, index, ratings1!, fetchPlacesPostProvider);
              //   },
              //   child: const Text('Post Review'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComment(
      String text,
      String author,
      int likesCount,
      String image,
      bool likedByMe,
      double rating,
      String placeId,
      String reviewId,
      FetchPlacesPostProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: 38,
              height: 38,
              imageUrl: "${ApiConstants.imageBaseUrl}/$image",
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          // Container(
          //   width: 38,
          //   height: 38,
          //   decoration: ShapeDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage("${ApiConstants.imageBaseUrl}/$image"),
          //       fit: BoxFit.fill,
          //     ),
          //     shape: const OvalBorder(),
          //   ),
          // ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      author,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7A3027),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Spacer(),
                    Text(
                      '$likesCount',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () async {
                        await provider.likeComment(userID!, placeId, reviewId);
                      },
                      child: Icon(
                        likedByMe ? Icons.favorite : Icons.favorite_border,
                        color: likedByMe ? Colors.red : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    ignoreGestures: true,
                    itemBuilder: (context, index) {
                      return SvgPicture.asset(
                        index < rating
                            ? 'assets/svg/star2.svg'
                            : 'assets/svg/star.svg',
                      );
                    },
                    onRatingUpdate: (newRating) {
                      // Handle rating update
                      // print(newRating);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController _reviewController = TextEditingController();

  void _addReview(BuildContext context, int index, double rating,
      FetchPlacesPostProvider fetchPlacesPostProvider) async {
    final reviewText = _reviewController
        .text; // You can get this dynamically based on user input
    final userId = userID; // Replace with actual user ID
    final placeId =
        fetchPlacesPostProvider.fetchPlacesModel.data![index].palaceId;

    if (reviewText.isNotEmpty) {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/review_add"),
        headers: {'Accept': 'application/json'},
        body: {
          'users_customers_id': userId,
          'place_id': placeId.toString(),
          'rating': rating.toString(),
          'review': reviewText,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        print(responseData['message']);
        _reviewController.clear();
        fetchPlacesPostProvider.refreshData(userId!);
        Navigator.pop(context); // Close the bottom sheet
      } else {
        print("Failed to add review: ${responseData['message']}");
      }
    }
  }
}
