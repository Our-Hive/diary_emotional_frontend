import 'package:emotional_app/features/support_network/ui/widgets/add_support_network_search.dart';
import 'package:emotional_app/features/support_network/ui/widgets/support_network_list.dart';
import 'package:flutter/material.dart';

class SupportNetworkHome extends StatelessWidget {
  const SupportNetworkHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: constraints.maxHeight * 0.7,
          width: double.infinity,
          color: Color(0xFFDECAAD),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Red de apoyo",
                  style: textTheme.headlineLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Text(
                  "En esta sección podrás encontrar información sobre tu red de apoyo emocional.",
                  style: textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                AddSupportNetworkSearch(),
                SupportNetworkList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
