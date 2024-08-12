import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/main.dart';
import 'package:penny_places/presentation/providers/getProfileProvider.dart';
import 'package:penny_places/presentation/providers/postPlaceCountProvider.dart';

import 'package:penny_places/presentation/screens/profileScreens/currentUserProfile/private_post_section.dart';
import 'package:penny_places/presentation/screens/profileScreens/currentUserProfile/public_post_section.dart';
import 'package:penny_places/presentation/screens/profileScreens/otherUserProfile/other_user_private_post.dart';
import 'package:penny_places/presentation/screens/profileScreens/otherUserProfile/other_user_public_post.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class OtherUserProfile extends StatefulWidget {
  final String? userID;
  const OtherUserProfile({super.key, this.userID});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  loadData() async {
    if (widget.userID != null) {
      await Provider.of<PostPlaceCountProvider>(context, listen: false)
          .getPostPlaceCount(widget.userID!);
      await Provider.of<GetProfileProvider>(context, listen: false)
          .getProfile(widget.userID!);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        body: Consumer<GetProfileProvider>(
            builder: (context, getProfileProvider, child) {
          return getProfileProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: CachedNetworkImage(
                        fadeOutCurve: Curves.easeOut,
                        fadeOutDuration: const Duration(milliseconds: 1000),
                        height: 120,
                        width: 120,
                        imageUrl:
                            "https://penny.eigix.net/public/${getProfileProvider.getProfileModel.data!.profilePicture}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 120,
                              width: 120,
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
                    // Center(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(64),
                    //     child: SizedBox(
                    //       height: 120,
                    //       width: 120,
                    //       child: Container(
                    //         height: 120,
                    //         width: 120,
                    //         decoration: ShapeDecoration(
                    //           image: DecorationImage(
                    //             image: NetworkImage(
                    //                 "https://penny.eigix.net/public/$profilePic"),
                    //             fit: BoxFit.cover,
                    //           ),
                    //           shape: const OvalBorder(),
                    //         ),
                    //       ), // Empty container as a fallback
                    //     ),
                    //   ),
                    // ),

                    addHeight(10),
                    Center(
                      child: Text(
                        getProfileProvider.getProfileModel.data!.userName!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    addHeight(10),
                    SizedBox(
                      width: 320,
                      child: Text(
                        getProfileProvider.getProfileModel.data!.profileBio ??
                            'Penny Places',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF7F8C8D),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                    addHeight(23),
                    Container(
                      width: 299,
                      height: 79,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 14),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F2F2).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFEEEEEE)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Consumer<PostPlaceCountProvider>(
                                    builder: (context, provider, child) {
                                      return SizedBox(
                                        width: 95,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: 26,
                                              child: Text(
                                                (provider
                                                            .postPlaceCountModel
                                                            .data
                                                            ?.reviewedPostCount ??
                                                        0)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color:
                                                      ConstantsColors.blueColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            const SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                "Post",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF7F8C8D),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/svg/line.svg',
                                color: const Color(0xFFAEAEAE),
                              ),
                              Row(
                                children: [
                                  Consumer<PostPlaceCountProvider>(
                                      builder: (context, provider, child) {
                                    return SizedBox(
                                      width: 95,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: 26,
                                            child: Text(
                                              (provider.postPlaceCountModel.data
                                                          ?.reviewedPostCount ??
                                                      0)
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color:
                                                    ConstantsColors.blueColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          const SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'Places Rated',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF7F8C8D),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    addHeight(23),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 327,
                        height: 50,
                        // height: height * 0.075,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xFFF7F7F7),
                        ),
                        child: TabBar(
                          // physics: const AlwaysScrollableScrollPhysics(),
                          // controller: _tabController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          labelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: const Color(0xFF7F8C8D),
                          //isScrollable: true,
                          dividerColor: const Color(0xFFF7F7F7),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          indicatorColor: Colors.pink,
                          //
                          indicator: BoxDecoration(
                            // border: Border(top: 10, left: 10, right: 10, bottom: ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            color: ConstantsColors.blueColor,
                          ),
                          tabs: [
                            Container(
                              width: 160,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                // color: Color.fromRGBO(248, 249, 251, 1),
                              ),
                              child: const Tab(
                                text: "Public Post",
                              ),
                            ),
                            Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16),
                                // color: Color.fromRGBO(248, 249, 251, 1),
                              ),
                              child: const Tab(
                                text: "Private Post",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const ScrollPhysics(),
                        //physics: NeverScrollableScrollPhysics(),
                        // physics: AlwaysScrollableScrollPhysics(),
                        // controller: _tabController,
                        children: [
                          OtherUserPublicPost(
                            userID: widget.userID!,
                          ),
                          OtherUserPrivatePost(
                            userID: widget.userID!,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  Widget buildShimmer() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
