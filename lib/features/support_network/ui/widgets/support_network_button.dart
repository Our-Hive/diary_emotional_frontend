import 'package:emotional_app/features/support_network/ui/widgets/support_network_home.dart';
import 'package:flutter/material.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';

class SupportNetworkButton extends StatelessWidget {
  final Color color;
  const SupportNetworkButton({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: Icon(Icons.hive),
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: ColorUtils.darken(
          color,
          0.4,
        ),
      ),
      onPressed: () => showBottomSheet(
        context: context,
        builder: (BuildContext context) => SupportNetworkHome(),
      ),
      label: Text("Red de apoyo"),
    );
  }
}
