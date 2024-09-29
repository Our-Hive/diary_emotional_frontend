import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/shared/domain/utils/date_time_formatter.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/info_button.dart';
import 'package:flutter/material.dart';

class RecordTrascendentalDetail extends StatelessWidget {
  final TrascendentalRecord record;
  const RecordTrascendentalDetail({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor =
        record.secondaryEmotion.colorBrightness == EmotionTheme.DARK
            ? Colors.white
            : Colors.black;
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: HexColor(record.secondaryEmotion.color),
            width: 3,
          ),
          color: ColorUtils.darken(
            HexColor(record.secondaryEmotion.color),
            0.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor(record.primaryEmotion.color),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    width: 50,
                    height: 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            record.primaryEmotion.name,
                            style: textTheme.titleLarge!.copyWith(
                              color: textColor,
                            ),
                          ),
                          Text(
                            record.secondaryEmotion.name,
                            style: textTheme.titleSmall!.copyWith(
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InfoButton(
                        title: record.secondaryEmotion.name,
                        body: record.secondaryEmotion.description,
                        titleColor: HexColor(record.primaryEmotion.color),
                        iconColor: record.secondaryEmotion.colorBrightness ==
                                EmotionTheme.DARK
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        DateTimeFormatter.getFormattedDate(record.date),
                        style: textTheme.bodyLarge!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                color:
                    record.secondaryEmotion.colorBrightness == EmotionTheme.DARK
                        ? Colors.white
                        : Colors.black,
              ),
              ImportantSection(record: record),
            ],
          ),
        ),
      ),
    );
  }
}

class ImportantSection extends StatelessWidget {
  const ImportantSection({
    super.key,
    required this.record,
  });

  final TrascendentalRecord record;

  @override
  Widget build(BuildContext context) {
    final colorCard = HexColor(record.primaryEmotion.color);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImportantTrascendentalRecord(
              title: record.location,
              bgColor: colorCard,
            ),
            ImportantTrascendentalRecord(
              title: record.activity,
              bgColor: colorCard,
            ),
          ],
        ),
        ImportantTrascendentalRecord(
          title: record.companions,
          bgColor: colorCard,
        ),
      ],
    );
  }
}

class ImportantTrascendentalRecord extends StatelessWidget {
  final String title;
  final Color bgColor;
  const ImportantTrascendentalRecord({
    super.key,
    required this.title,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
