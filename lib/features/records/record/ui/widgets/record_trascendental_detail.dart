import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:flutter/material.dart';

class RecordTrascendentalDetail extends StatelessWidget {
  final TrascendentalRecord record;
  const RecordTrascendentalDetail({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => print(""),
      child: Text(
        record.date.toString(),
      ),
    );
  }
}
