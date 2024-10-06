import 'package:emotional_app/features/support_network/ui/provider/support_network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/support_network/ui/provider/add_user_to_network_provider.dart';
import 'package:emotional_app/features/support_network/ui/widgets/add_support_network_search.dart';
import 'package:emotional_app/features/support_network/ui/widgets/support_network_list.dart';
import 'package:flutter/material.dart';

class SupportNetworkHome extends ConsumerWidget {
  const SupportNetworkHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    ref.listen(
      addUserToNetworkProvider,
      (pervious, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: appColors.error,
              content: Text(
                state.errorMessage,
                style: TextStyle(
                  color: appColors.onError,
                ),
              ),
            ),
          );
          return;
        }
        if (state.isSuccess) {
          ref.read(supportNetworkProvider.notifier).getSupportNetwork();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: appColors.surface,
              content: Text(
                "Usuario añadido",
                style: TextStyle(
                  color: appColors.primary,
                ),
              ),
            ),
          );
        }
      },
    );
    ref.listen(
      supportNetworkProvider,
      (pervious, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: appColors.error,
              content: Text(
                state.errorMessage,
                style: TextStyle(
                  color: appColors.onError,
                ),
              ),
            ),
          );
          return;
        }
      },
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: constraints.maxHeight * 0.7,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFDECAAD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
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
