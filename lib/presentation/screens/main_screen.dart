import 'package:flutter/material.dart';
import 'package:penny_places/presentation/screens/nav_bar.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({
    super.key, required this.index,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: NavBar(
        index: widget.index
      ),
    );
  }
}
