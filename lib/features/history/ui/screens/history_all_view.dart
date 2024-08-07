import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';

class HistoryAllView extends StatelessWidget {
  const HistoryAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmotionCard(
              primaryEmotion: 'Miedo',
              secondaryEmotion: 'Fobia',
              primaryColor: Color(0xFF9C21E8),
              bgColor: Color(0xFF28083C),
            ),
            SizedBox(height: 10),
            EmotionCard(
              secondaryEmotion: 'Sad',
              primaryColor: Color(0xFF214DE8),
              bgColor: Color(0xFF00061D),
            ),
          ],
        ),
      ),
    );
  }
}
