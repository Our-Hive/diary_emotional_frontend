import 'package:flutter/material.dart';

class RecordTrascendentalDetail extends StatefulWidget {
  const RecordTrascendentalDetail({super.key});

  @override
  State<RecordTrascendentalDetail> createState() =>
      _RecordTrascendentalDetailState();
}

class _RecordTrascendentalDetailState extends State<RecordTrascendentalDetail> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => print(""),
      child: const Text(
        'Record Trascendental Detail',
      ),
    );
  }
}
