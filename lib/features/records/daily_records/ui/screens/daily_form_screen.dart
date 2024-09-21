import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/records/daily_records/infrastructure/external/exceptions/cant_create_record_exception.dart';
import 'package:emotional_app/features/records/daily_records/ui/providers/daily_form_provider.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DailyFormScreen extends ConsumerWidget {
  const DailyFormScreen({
    super.key,
    required String recordType,
    required String emotion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    ref.listen(
      dailyFormProvider,
      (prev, state) {
        if (state.status == DailyFormStatus.success) {
          context.goNamed(AppRoutesName.homeView);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: HexColor(
                ref.watch(dailyFormProvider).primaryEmotionSelected.color,
              ),
              content: const Text(
                'Registro guardado con éxito',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        if (state.status == DailyFormStatus.error) {
          if (state.errorMessage == CantCreateRecordException().message) {
            context.goNamed(AppRoutesName.homeView);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: appColors.error,
              content: Text(
                state.errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appColors.onError,
                ),
              ),
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diario Emocional'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    ref
                        .watch(dailyFormProvider)
                        .primaryEmotionSelected
                        .name
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor(
                        ref
                            .watch(dailyFormProvider)
                            .primaryEmotionSelected
                            .color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ref
                        .watch(dailyFormProvider)
                        .secondaryEmotionSelected
                        .name
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor(
                        ref
                            .watch(dailyFormProvider)
                            .secondaryEmotionSelected
                            .color,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                maxLines: 8,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Exprésate Aquí :D',
                ),
                onChanged: (value) => ref
                    .read(dailyFormProvider.notifier)
                    .onDescriptionChange(value),
              ),
              FilledButton(
                onPressed: () =>
                    ref.read(dailyFormProvider.notifier).onFormSubmit(),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Guardar\nRegistro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
