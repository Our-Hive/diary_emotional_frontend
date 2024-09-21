import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/records/daily_records/ui/providers/daily_form_provider.dart';
import 'package:emotional_app/features/home/ui/providers/emotions_provider.dart';
import 'package:emotional_app/features/records/trascendental_records/ui/providers/trascendental_record_provider.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/color/hex_color.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SecondaryEmotionScreen extends ConsumerStatefulWidget {
  final String emotion;
  final String recordType;

  const SecondaryEmotionScreen({
    super.key,
    required this.emotion,
    required this.recordType,
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
                    separatorBuilder: (_, i) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => EmotionCard(
                      secondaryEmotion: secondaryEmotions[i].name,
                      primaryColor: HexColor(secondaryEmotions[i].color),
                      description: secondaryEmotions[i].description,
                      onTap: () {
                        if (widget.recordType == RecordTypes.daily) {
                          final emotionSelected = secondaryEmotions[i];
                          ref
                              .read(dailyFormProvider.notifier)
                              .onSecondaryEmotionSelect(emotionSelected);
                          context.pushNamed(
                            AppRoutesName.diaryFormScreen,
                            pathParameters: {
                              'recordType': widget.recordType,
                              'emotion': widget.emotion,
                            },
                          );
                        }
                        if (widget.recordType == RecordTypes.transcendental) {
                          final emotionSelected = secondaryEmotions[i];
                          ref
                              .read(trascendentalFormProvider.notifier)
                              .onSecondaryEmotionSelect(emotionSelected);
                          context.pushNamed(
                            AppRoutesName.trascendentalFormScreen,
                            pathParameters: {
                              'recordType': widget.recordType,
                              'emotion': widget.emotion,
                            },
                          );
                        }
                      },
                      bgColor: ColorUtils.darken(
                        HexColor(secondaryEmotions[i].color),
                        .2,
                      ),
                      textColor: secondaryEmotions[i].colorBrightness ==
                              EmotionTheme.DARK
                          ? Colors.white
                          : Colors.black,
                    ),
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
