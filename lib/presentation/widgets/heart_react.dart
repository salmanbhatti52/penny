import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeartIconWidget extends StatefulWidget {
  const HeartIconWidget({super.key});

  @override
  _HeartIconWidgetState createState() => _HeartIconWidgetState();
}

class _HeartIconWidgetState extends State<HeartIconWidget> {
  bool isFilled = false; // Step 2: State variable to track if heart is filled

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Step 3: Use GestureDetector to handle taps
      onTap: () {
        setState(() {
          // Step 4: Toggle the state variable on tap
          isFilled = !isFilled;
        });
      },
      child: SvgPicture.asset(
        isFilled
            ? 'assets/svg/heartF.svg'
            : 'assets/svg/heart.svg', // Switch between filled and unfilled SVG
      ),
    );
  }
}
