import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/info_button.dart';
import 'package:flutter/material.dart';

class RecordDailyDetail extends StatelessWidget {
  final DailyRecord record;

  const RecordDailyDetail({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor =
        record.secondaryEmotion.colorBrightness == EmotionTheme.DARK
            ? Colors.black
            : Colors.white;
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
          child: Row(
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
                      Divider(
                        color: record.secondaryEmotion.colorBrightness ==
                                EmotionTheme.DARK
                            ? Colors.white
                            : Colors.black,
                      ),
                      if (record.description.isNotEmpty)
                        Text(
                          record.description,
                          style: textTheme.bodyLarge!.copyWith(
                            color: textColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              InfoButton(
                title: record.secondaryEmotion.name,
                body: record.secondaryEmotion.description,
                titleColor: HexColor(record.primaryEmotion.color),
                iconColor:
                    record.secondaryEmotion.colorBrightness == EmotionTheme.DARK
                        ? Colors.white
                        : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
