import 'package:emotional_app/features/home/ui/widgets/app_bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  final Widget childView;
  const HomeLayout({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const AppBottomNavbar(),
    );
  }
}
