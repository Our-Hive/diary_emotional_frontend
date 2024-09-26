import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/history/ui/providers/history_provider.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryTrascendentalView extends ConsumerStatefulWidget {
  const HistoryTrascendentalView({super.key});

  @override
  HistoryAllViewState createState() => HistoryAllViewState();
}

class HistoryAllViewState extends ConsumerState<HistoryTrascendentalView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(historyProvider.notifier).getTrascendentalRecords();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        ref.read(historyProvider.notifier).loadNextPageTrascendental();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TrascendentalRecord> records =
        ref.watch(historyProvider).trascendentalRecords;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(historyProvider.notifier).getTrascendentalRecords(),
          child: ListView.separated(
            itemCount: records.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final record = records[i];
              return EmotionCard(
                primaryEmotion: record.primaryEmotion.name,
                secondaryEmotion: record.secondaryEmotion.name,
                primaryColor: HexColor(record.secondaryEmotion.color),
                onTap: () => context.pushNamed(
                  AppRoutesName.recordDetail,
                  pathParameters: {
                    'recordId': record.id,
                    'recordType': RecordTypes.transcendental,
                  },
                ),
                bgColor: ColorUtils.darken(
                  HexColor(record.secondaryEmotion.color),
                  .2,
                ),
                textColor:
                    record.secondaryEmotion.colorBrightness == EmotionTheme.DARK
                        ? Colors.white
                        : Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}
