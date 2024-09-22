import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/history/ui/providers/history_provider.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';

class HistoryTrascendentalView extends ConsumerStatefulWidget {
  const HistoryTrascendentalView({super.key});

  @override
  HistoryAllViewState createState() => HistoryAllViewState();
}

class HistoryAllViewState extends ConsumerState<HistoryTrascendentalView> {
  @override
  void initState() {
    ref.read(historyProvider.notifier).getHistory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Record> records = ref.watch(historyProvider).dailyRecords;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(itemBuilder: (_, i) {
          return EmotionCard(
            primaryEmotion: records[i].primaryEmotion.name,
            secondaryEmotion: records[i].secondaryEmotion.name,
            primaryColor: HexColor(records[i].primaryEmotion.color),
            onTap: () => print('Tapped'),
            bgColor: ColorUtils.darken(
              HexColor(records[i].primaryEmotion.color),
              .2,
            ),
            textColor:
                records[i].primaryEmotion.colorBrightness == EmotionTheme.DARK
                    ? Colors.white
                    : Colors.black,
          );
        }),
      ),
    );
  }
}
