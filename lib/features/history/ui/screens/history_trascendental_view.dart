import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';

class HistoryTrascendentalView extends StatelessWidget {
  const HistoryTrascendentalView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmotionCard(
              primaryEmotion: 'Rabia',
              secondaryEmotion: 'Celos',
              primaryColor: Color(0xFFF42A55),
              bgColor: Color(0xFF1D0000),
            ),
            SizedBox(height: 10),
            EmotionCard(
              secondaryEmotion: 'Poderoso',
              primaryColor: Color(0xFFFFD600),
              bgColor: Color(0xFF2C1500),
              buttonTextColor: Color(0xFF2C1500),
            ),
          ],
        ),
      ),
    );
  }
}
