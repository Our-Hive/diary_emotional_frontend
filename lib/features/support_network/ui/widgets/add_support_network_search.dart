import 'package:emotional_app/features/support_network/ui/provider/add_user_to_network_provider.dart';
import 'package:emotional_app/features/support_network/ui/provider/support_network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AddSupportNetworkSearch extends ConsumerWidget {
  const AddSupportNetworkSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).colorScheme;
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => ref
                    .read(addUserToNetworkProvider.notifier)
                    .onUsernameChanged(value),
                decoration: InputDecoration(
                  hintText: "Ingresa username",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(addUserToNetworkProvider.notifier).onSubmit(),
              icon: const Icon(Icons.add),
              label: const Text("Añadir"),
            ),
          ],
        ),
      ),
    );
  }
}
