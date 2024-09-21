import 'package:emotional_app/features/records/record/ui/widgets/record_daily_detail.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_trascendental_detail.dart';
import 'package:emotional_app/shared/domain/records/record_types.dart';
import 'package:flutter/material.dart';

class RecordDetailScreen extends StatelessWidget {
  final String recordId;
  final String recordType;

  const RecordDetailScreen({
    super.key,
    required this.recordId,
    required this.recordType,
  });

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
              'Record ID: $recordId',
              style: const TextStyle(fontSize: 30),
            ),
            if (recordType == RecordTypes.daily)
              const RecordDailyDetail()
            else
              const RecordTrascendentalDetail(),
          ],
        ),
      ),
    );
  }
}
