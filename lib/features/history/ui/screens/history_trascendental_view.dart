import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';

class HistoryTrascendentalView extends StatelessWidget {
  const HistoryTrascendentalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmotionCard(
              primaryEmotion: 'Rabia',
              secondaryEmotion: 'Celos',
              primaryColor: const Color(0xFFF42A55),
              bgColor: const Color(0xFF1D0000),
              onTap: () => print('Tapped'),
            ),
            const SizedBox(height: 10),
            EmotionCard(
              secondaryEmotion: 'Poderoso',
              primaryColor: const Color(0xFFFFD600),
              bgColor: const Color(0xFF2C1500),
              buttonTextColor: const Color(0xFF2C1500),
              onTap: () => print('Tapped'),
            ),
          ],
        ),
      ),
    );
  }
}
