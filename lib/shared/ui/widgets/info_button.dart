import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final String title;
  final String body;
  final Color titleColor;
  final Color iconColor;
  const InfoButton({
    super.key,
    required this.title,
    required this.body,
    required this.titleColor,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontSize: textTheme.headlineLarge!.fontSize,
                fontWeight: textTheme.headlineLarge!.fontWeight,
                color: ColorUtils.lighten(titleColor, 0.2),
              ),
            ),
            content: Text(
              body,
              style: textTheme.bodyLarge,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: appColors.error,
                ),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      ),
      icon: Icon(
        Icons.info_outline,
        size: 35,
        color: iconColor,
      ),
    );
  }
}
