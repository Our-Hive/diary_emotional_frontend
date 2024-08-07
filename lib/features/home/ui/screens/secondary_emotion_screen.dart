import 'package:emotional_app/features/home/ui/providers/emotions_provider.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/color/hex_color.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondaryEmotionScreen extends ConsumerStatefulWidget {
  final String emotion;
  const SecondaryEmotionScreen({
    super.key,
    required this.emotion,
  });

  @override
  ConsumerState<SecondaryEmotionScreen> createState() =>
      _SecondaryEmotionScreenState();
}

class _SecondaryEmotionScreenState
    extends ConsumerState<SecondaryEmotionScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(emotionsProvider.notifier).getSecondaryEmotions(widget.emotion);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emotion.toUpperCase()),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Selecciona la emoción secundaria',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (context, watch, child) {
                  final secondaryEmotions =
                      ref.watch(emotionsProvider).secondaryEmotions;
                  return ListView.separated(
                    itemCount: secondaryEmotions.length,
                    itemBuilder: (context, i) => EmotionCard(
                      secondaryEmotion: secondaryEmotions[i].name,
                      primaryColor: HexColor(secondaryEmotions[i].color),
                      description: secondaryEmotions[i].description,
                      onTap: () => print('Tapped'),
                      bgColor: ColorUtils.darken(
                        HexColor(secondaryEmotions[i].color),
                        .6,
                      ),
                      buttonTextColor:
                          secondaryEmotions[i].colorBrightness == 'dark'
                              ? Colors.white
                              : Colors.black,
                    ),
                    separatorBuilder: (_, i) => const SizedBox(height: 10),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
