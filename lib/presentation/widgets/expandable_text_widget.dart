import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;

  // Declare _toggleExpand method here
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // Widget to display when not expanded
  Widget _buildCollapsed() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            '${widget.text.substring(0, 45)}...',
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        InkWell(
          onTap: _toggleExpand, // Now _toggleExpand is declared before use
          child: Text(
            'more',
            style: GoogleFonts.poppins(
              color: const Color(0xFF7F8C8D),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  // Widget to display when expanded
  Widget _buildExpanded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.text,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        InkWell(
          onTap: _toggleExpand,
          child: const Text(
            'less',
            style: TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildExpanded() : _buildCollapsed();
  }
}
