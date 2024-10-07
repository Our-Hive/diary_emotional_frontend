import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/widgets/emotional_roulette.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_daily_detail.dart';
import 'package:emotional_app/features/records/record/ui/widgets/record_trascendental_detail.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/features/support_network/ui/provider/support_network_history_provider.dart';
import 'package:emotional_app/shared/ui/color/color_utils.dart';
import 'package:emotional_app/shared/ui/widgets/emotion_card.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SupportNetworkHistory extends ConsumerStatefulWidget {
  final int userId;
  const SupportNetworkHistory({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<SupportNetworkHistory> createState() =>
      _SupportNetworkHistoryState();
}

class _SupportNetworkHistoryState extends ConsumerState<SupportNetworkHistory> {
  @override
  void initState() {
    ref.read(supportNetworkHistoryProvider.notifier).getHistoryByUser(
          widget.userId,
        );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // show Dialog with the history detail using the history card
    final state = ref.watch(supportNetworkHistoryProvider);
    return Scaffold(
      appBar: OurHiveAppBar(
        title: 'Historial de emociones',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (ref.watch(supportNetworkHistoryProvider).history.isEmpty)
              Text('No hay historial')
            else
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    final record = state.history[index];
                    return EmotionCard(
                      primaryEmotion: record.primaryEmotion.name,
                      secondaryEmotion: record.secondaryEmotion.name,
                      primaryColor: HexColor(
                        record.primaryEmotion.color,
                      ),
                      bgColor: ColorUtils.darken(
                        HexColor(
                          record.secondaryEmotion.color,
                        ),
                      ),
                      textColor: record.secondaryEmotion.colorBrightness ==
                              EmotionTheme.DARK
                          ? Colors.white
                          : Colors.black,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (
                            context,
                          ) =>
                              AlertDialog(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Detalle del registro',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: ColorUtils.lighten(
                                              HexColor(
                                                record.secondaryEmotion.color,
                                              ),
                                              0.2,
                                            ),
                                          ),
                                    ),
                                    CloseIconButtonDialog(),
                                  ],
                                ),
                                Divider(
                                  color: ColorUtils.lighten(
                                    HexColor(
                                      record.secondaryEmotion.color,
                                    ),
                                    0.2,
                                  ),
                                  thickness: 2,
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (record is DailyRecord)
                                  RecordDailyDetail(
                                    record: record,
                                  )
                                else if (record is TrascendentalRecord)
                                  RecordTrascendentalDetail(
                                    record: record,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CloseIconButtonDialog extends StatelessWidget {
  const CloseIconButtonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      style: TextButton.styleFrom(
        foregroundColor: appColors.error,
      ),
      icon: Icon(
        Icons.close,
        color: appColors.error,
      ),
    );
  }
}
