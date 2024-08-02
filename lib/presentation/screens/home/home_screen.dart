import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/core/helper/size_box_extension.dart';
import 'package:penny_places/presentation/widgets/expandable_text_widget.dart';
import 'package:penny_places/presentation/widgets/heart_react.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  // keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefix: Container(width: 16),
                    filled: true, // Add this line
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
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // labelText: 'Email',
                    hintText: 'Type here to Search...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFFEEEEEE)), // change border color
                    ),
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF7F8C8D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
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
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 47,
                                      height: 47,
                                      decoration: const ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.pexels.com/photos/26088418/pexels-photo-26088418/free-photo-of-a-woman-in-a-black-dress-and-sunglasses.jpeg"),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'John Doe',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '2 days ago',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF7F8C8D),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/building.svg',
                                  ),
                                  addWidth(4),
                                  Text(
                                    'Patric Tomasso Restaurant',
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
                                    'Normanday Ave, 30126, Near Paris State, France',
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
                                    'Restaurant',
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
                        Container(
                          width: 390,
                          height: 213,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/26088418/pexels-photo-26088418/free-photo-of-a-woman-in-a-black-dress-and-sunglasses.jpeg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         'John Doe Just visited the iconic Eiffel Tower in Paris!',
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.black,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8, right: 5),
                          child: ExpandableTextWidget(
                            text:
                                "In digital photography, a pixel refers to the smallest unit of a digital image captured by a camera's image sensor. Each pixel represents a specific color and brightness value, which collectively form the photograph. The number of pixels in an image sensor determines the resolution and detail captured by the camera.",
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 3, top: 4, right: 8),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3.5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 24.0, // Adjust the size of the stars
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, index) {
                                  return index <
                                          (2.5 /* Your dynamic rating value here */)
                                      ? SvgPicture.asset(
                                          'assets/svg/star2.svg') // Filled star image
                                      : SvgPicture.asset(
                                          'assets/svg/star.svg'); // Empty star image
                                },
                                onRatingUpdate: (rating) {
                                  // Update the state that holds the rating value
                                  // For example, using a state management solution or setState in a StatefulWidget
                                  print(rating);
                                },
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some space between the stars and the rating text
                              Text(
                                '(3.0)',
                                style: GoogleFonts.poppins(
                                  color: ConstantsColors.blueColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ), // Display the rating result dynamically
                              const Spacer(),
                              Text(
                                '30',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF7F8C8D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const HeartIconWidget(),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 5, top: 4),
                          child: Text(
                            'View all 2 Reviews',
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
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/16785579/pexels-photo-16785579/free-photo-of-table-near-windows-in-cafe.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                              addWidth(4),
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context);
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
                        const Divider(),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildComment(
                  'Donec a eros justo. Fusce egestas tristique ultrices. Nam tempor, augue nec tincidunt molestie, massa.',
                  'John Doe'),
              _buildComment('Nice work!', 'Jane Smith'),
              _buildComment('Awesome!', 'James Brown'),
              const SizedBox(height: 16),
              Row(
                // mainAxisAlignment: MainAxisAlignment.,
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/19887636/pexels-photo-19887636/free-photo-of-woman-posing-in-green-dress.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  addWidth(5),
                  Text(
                    'Add a Review...',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComment(String text, String author) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.pexels.com/photos/20185297/pexels-photo-20185297/free-photo-of-cafe-text-on-cafe-window.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
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
                    addWidth(5),
                    Text(
                      '2d',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '30',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7F8C8D),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    addWidth(4),
                    const HeartIconWidget(),
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
                RatingBar.builder(
                  initialRating: 3.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 18.0, // Adjust the size of the stars
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, index) {
                    return index < (2.5 /* Your dynamic rating value here */)
                        ? SvgPicture.asset(
                            'assets/svg/star2.svg') // Filled star image
                        : SvgPicture.asset(
                            'assets/svg/star.svg'); // Empty star image
                  },
                  onRatingUpdate: (rating) {
                    // Update the state that holds the rating value
                    // For example, using a state management solution or setState in a StatefulWidget
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
