import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeartIconWidget extends StatefulWidget {
  final bool isFilled;
  final VoidCallback onTap;

  const HeartIconWidget({
    Key? key,
    required this.isFilled,
    required this.onTap,
  }) : super(key: key);

  @override
  _HeartIconWidgetState createState() => _HeartIconWidgetState();
}

class _HeartIconWidgetState extends State<HeartIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SvgPicture.asset(
        widget.isFilled
            ? 'assets/svg/heartF.svg'
            : 'assets/svg/heart.svg', // Switch between filled and unfilled SVG
      ),
    );
  }
}
