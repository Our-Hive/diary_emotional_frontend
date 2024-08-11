import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:flutter/material.dart';

class PrimaryEmotionScreen extends StatelessWidget {
  final String recordType;
  const PrimaryEmotionScreen({super.key, required this.recordType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoción primaria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona la emoción primaria',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            EmotionalRoulette(
              recordType: recordType,
            ),
          ],
        ),
      ),
    );
  }
}
