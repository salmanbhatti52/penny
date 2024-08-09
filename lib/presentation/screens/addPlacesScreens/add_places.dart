import 'package:flutter/material.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/presentation/providers/addPlacesProvider.dart';

import 'package:penny_places/presentation/screens/addPlacesScreens/private_post_screen.dart';
import 'package:penny_places/presentation/screens/addPlacesScreens/public_post_screen.dart';

class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

  @override
  _AddPlacesState createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final AddPlacesProvider _addPlacesProvider = AddPlacesProvider();

  @override
  void dispose() {
    _addPlacesProvider.dispose();
    super.dispose();
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
          automaticallyImplyLeading: false, // Add this line

          title: const Text(
            'Add Places',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        body: Column(
          children: [
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            const Expanded(
              child: TabBarView(
                physics: ScrollPhysics(),
                //physics: NeverScrollableScrollPhysics(),
                // physics: AlwaysScrollableScrollPhysics(),
                // controller: _tabController,
                children: [
                  PublicPostScreen(),
                  PrivatePostScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
