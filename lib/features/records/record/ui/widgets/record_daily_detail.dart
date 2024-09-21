import 'package:flutter/material.dart';

class RecordDailyDetail extends StatefulWidget {
  const RecordDailyDetail({super.key});

  @override
  State<RecordDailyDetail> createState() => _RecordDailyDetailState();
}

class _RecordDailyDetailState extends State<RecordDailyDetail> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => print(""),
      child: const Text(
        'Record Daily Detail',
      ),
    );
  }
}
