import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/ui/providers/history_provider.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryDiaryView extends ConsumerStatefulWidget {
  const HistoryDiaryView({super.key});

  @override
  HistoryAllViewState createState() => HistoryAllViewState();
}

class HistoryAllViewState extends ConsumerState<HistoryDiaryView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    ref.read(historyProvider.notifier).getDailyRecords();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        ref.read(historyProvider.notifier).loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyProvider);
    final List<DailyRecord> records = state.dailyRecords;
    return state.errorMessages.isNotEmpty
        ? Center(
            child: Text(state.errorMessages),
          )
        : records.isEmpty && state.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    const Text('Cargando registros...'),
                  ],
                ),
              )
            : _BuildDailyList(
                records: records,
                scrollController: scrollController,
              );
  }
}

class _BuildDailyList extends ConsumerWidget {
  final List<DailyRecord> records;
  final ScrollController scrollController;

  const _BuildDailyList({
    required this.records,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () => ref.read(historyProvider.notifier).getDailyRecords(),
          child: ListView.separated(
            itemCount: records.length,
            separatorBuilder: (__, _) => const SizedBox(height: 10),
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
                    'recordType': RecordTypes.daily,
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
