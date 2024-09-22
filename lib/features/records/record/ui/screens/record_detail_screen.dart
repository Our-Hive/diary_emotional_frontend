import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/ui/providers/history_provider.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_daily_detail.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_trascendental_detail.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Record ID: ${widget.recordId}',
              style: const TextStyle(fontSize: 30),
            ),
            if (dailyRecord is DailyRecord)
              RecordDailyDetail(record: dailyRecord!)
            else if (trascendentalRecord is TrascendentalRecord)
              RecordTrascendentalDetail(record: trascendentalRecord!),
          ],
        ),
      ),
    );
  }
}
