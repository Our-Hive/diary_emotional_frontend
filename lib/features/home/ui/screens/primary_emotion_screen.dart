import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:flutter/material.dart';

class PrimaryEmotionScreen extends StatelessWidget {
  const PrimaryEmotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primary Emotion'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecciona la emoción primaria',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            EmotionalRoulette(),
          ],
        ),
      ),
    );
  }
}
