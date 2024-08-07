import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';

class HistoryDiaryView extends StatelessWidget {
  const HistoryDiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmotionCard(
              primaryEmotion: 'Disgusto',
              secondaryEmotion: 'Asco',
              primaryColor: Color(0xFF57C877),
              bgColor: Color(0xFF001D05),
            ),
            SizedBox(height: 10),
            EmotionCard(
              primaryEmotion: 'Sorpresa',
              secondaryEmotion: 'Efusivo',
              primaryColor: Color(0xFFE821B0),
              bgColor: Color(0xFF1C001D),
            )
          ],
        ),
      ),
    );
  }
}
