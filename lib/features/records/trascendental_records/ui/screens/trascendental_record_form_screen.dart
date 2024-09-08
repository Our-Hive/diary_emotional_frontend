import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/trascendental_records/ui/providers/trascendental_record_provider.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_multicolor_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TrascendentalRecordFormScreen extends ConsumerWidget {
  const TrascendentalRecordFormScreen({
    super.key,
    required String recordType,
    required String emotion,
  });

  final mainSeparator = const SizedBox(height: 20);
  final secondarySeparator = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      trascendentalFormProvider,
      (_, state) {
        if (state.status == TrascendentalFormStatus.success) {
          context.goNamed(AppRoutesName.homeView);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Trascendental'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                OurHiveColorIcon(
                  color: HexColor(
                    ref
                        .watch(trascendentalFormProvider)
                        .primaryEmotionSelected
                        .color,
                  ),
                ),
                mainSeparator,
                const Text(
                  '¿Con quién viviste esta emoción?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                secondarySeparator,
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'ej. familia, amigos, pareja, solo, etc.',
                  ),
                  onChanged: ref
                      .watch(trascendentalFormProvider.notifier)
                      .onCompanionChange,
                ),
                mainSeparator,
                const Text(
                  '¿Dónde sucedió esta emoción?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                secondarySeparator,
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'ej. universidad, casa, trabajo, gym etc.',
                  ),
                  onChanged: ref
                      .watch(trascendentalFormProvider.notifier)
                      .onLocationChange,
                ),
                mainSeparator,
                const Text(
                  '¿Qué hacías?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                secondarySeparator,
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'ej. ejercicio, tarea, reunión, etc.',
                  ),
                  onChanged: ref
                      .watch(trascendentalFormProvider.notifier)
                      .onActivityChange,
                ),
                mainSeparator,
                FilledButton(
                  onPressed: () => ref
                      .read(trascendentalFormProvider.notifier)
                      .onFormSubmit(),
                  child: const Text("Guardar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
