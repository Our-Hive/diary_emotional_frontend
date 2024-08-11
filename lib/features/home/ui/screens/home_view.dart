import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/home/ui/widgets/home_card.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeByCard = size.height / 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <HomeCard>[
              HomeCard(
                title: 'Diario Emocional',
                description:
                    'Registra tus emociones que has sentido a lo largo de tu dia, con el fin de tener un control de tus emociones y diariamente ser mas consiente de ellas.',
                height: sizeByCard,
                imagePath: 'assets/images/diary.jpeg',
                onTap: () => context.pushNamed(
                  AppRoutesName.primaryEmotions,
                  pathParameters: {'recordType': RecordTypes.daily},
                ),
              ),
              HomeCard(
                title: 'Emociones Trascendentales',
                description:
                    'Conoce tus emociones, creando registros de tus emociones mas relevantes, usa esta herramienta para guardar los momentos en los cuales te sientes mas emocionado o te cuesta saber que sentiste en el momento.',
                height: sizeByCard,
                imagePath: 'assets/images/trascendental.jpeg',
                onTap: () => context.pushNamed(
                  AppRoutesName.primaryEmotions,
                  pathParameters: {'recordType': RecordTypes.transcendental},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
