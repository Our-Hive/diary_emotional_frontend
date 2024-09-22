import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/ui/providers/history_provider.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_daily_detail.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_trascendental_detail.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_multicolor_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordDetailScreen extends ConsumerStatefulWidget {
  final String recordId;
  final String recordType;

  const RecordDetailScreen({
    super.key,
    required this.recordId,
    required this.recordType,
  });

  @override
  RecordDetailScreenState createState() => RecordDetailScreenState();
}

class RecordDetailScreenState extends ConsumerState<RecordDetailScreen> {
  DailyRecord? dailyRecord;
  TrascendentalRecord? trascendentalRecord;

  @override
  void initState() {
    super.initState();
    if (widget.recordType == RecordTypes.daily) {
      dailyRecord =
          ref.read(historyProvider.notifier).findDailyRecord(widget.recordId);
    } else {
      trascendentalRecord = ref
          .read(historyProvider.notifier)
          .findTrascendentalRecord(widget.recordId);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 40);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recordType == RecordTypes.daily
              ? "Registro Diario"
              : "Registro Trascendental",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacer,
                OurHiveColorIcon(
                  color: dailyRecord != null
                      ? HexColor(
                          dailyRecord!.primaryEmotion.color,
                        )
                      : HexColor(
                          trascendentalRecord!.primaryEmotion.color,
                        ),
                ),
                spacer,
                Center(
                  child: dailyRecord is DailyRecord
                      ? RecordDailyDetail(record: dailyRecord!)
                      : RecordTrascendentalDetail(record: trascendentalRecord!),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
