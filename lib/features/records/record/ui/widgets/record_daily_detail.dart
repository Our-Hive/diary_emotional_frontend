import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:flutter/material.dart';

class RecordDailyDetail extends StatelessWidget {
  final DailyRecord record;

  const RecordDailyDetail({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => print(""),
      child: Text(
        record.description.toString(),
      ),
    );
  }
}
