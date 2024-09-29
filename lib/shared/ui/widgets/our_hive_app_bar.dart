import 'package:flutter/material.dart';

class OurHiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const OurHiveAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: true,
    );
  }
}
