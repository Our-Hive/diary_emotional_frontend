import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OurHiveColorIcon extends StatelessWidget {
  final Color color;
  const OurHiveColorIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Image.asset(
            'assets/app_image_yellow.png',
            width: 120,
            height: 120,
          )
        : ImageFiltered(
            imageFilter: ColorFilter.mode(
              color,
              BlendMode.srcATop,
            ),
            child: const Image(
              image: AssetImage('assets/app_image.png'),
              width: 120,
              height: 120,
            ),
          );
  }
}
