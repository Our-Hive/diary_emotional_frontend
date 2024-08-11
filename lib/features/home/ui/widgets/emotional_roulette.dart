import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/daily_records/ui/providers/daily_form_provider.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/ui/providers/emotions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexagon/hexagon.dart';

class EmotionalRoulette extends ConsumerStatefulWidget {
  final String recordType;
  const EmotionalRoulette({super.key, required this.recordType});

  @override
  EmotionalRouletteState createState() => EmotionalRouletteState();
}

class EmotionalRouletteState extends ConsumerState<EmotionalRoulette> {
  final HexagonType type = HexagonType.FLAT;
  final int depth = 1;

  Set<Emotion> emotions = <Emotion>{};

  Emotion? calculateEmotionText(int q, int r) {
    if (q == 1 && r == 0 && emotions.isNotEmpty) {
      return emotions.elementAt(0);
    } else if (q == 1 && r == -1 && emotions.isNotEmpty) {
      return emotions.elementAt(1);
    } else if (q == 0 && r == -1 && emotions.isNotEmpty) {
      return emotions.elementAt(2);
    } else if (q == -1 && r == 0 && emotions.isNotEmpty) {
      return emotions.elementAt(3);
    } else if (q == -1 && r == 1 && emotions.isNotEmpty) {
      return emotions.elementAt(4);
    } else if (q == 0 && r == 1 && emotions.isNotEmpty) {
      return emotions.elementAt(5);
    }
    return null;
  }

  String calculateEmotionDescription(int q, int r) {
    if (q == 1 && r == 0 && emotions.isNotEmpty) {
      return emotions.elementAt(0).description;
    } else if (q == 1 && r == -1 && emotions.isNotEmpty) {
      return emotions.elementAt(1).description;
    } else if (q == 0 && r == -1 && emotions.isNotEmpty) {
      return emotions.elementAt(2).description;
    } else if (q == -1 && r == 0 && emotions.isNotEmpty) {
      return emotions.elementAt(3).description;
    } else if (q == -1 && r == 1 && emotions.isNotEmpty) {
      return emotions.elementAt(4).description;
    } else if (q == 0 && r == 1 && emotions.isNotEmpty) {
      return emotions.elementAt(5).description;
    }
    return 'Este es el panel de emociones primarias, puedes seleccionar alguna que este a mi al rededor la cual exprese lo mejor posible lo que sientes en estos momentos.\n\nSi tienes alguna duda sobre alguna emoción, puedes mantener la emoción para obtener más información.';
  }

  Color calculateColor(int q, int r) {
    if (q == 1 && r == 0 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(0).color);
    } else if (q == 1 && r == -1 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(1).color);
    } else if (q == 0 && r == -1 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(2).color);
    } else if (q == -1 && r == 0 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(3).color);
    } else if (q == -1 && r == 1 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(4).color);
    } else if (q == 0 && r == 1 && emotions.isNotEmpty) {
      return HexColor(emotions.elementAt(5).color);
    }
    return Colors.white;
  }

  @override
  void initState() {
    super.initState();
    ref.read(emotionsProvider.notifier).getPrimaryEmotions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emotions = ref.watch(emotionsProvider).primaryEmotions;
    return InteractiveViewer(
      minScale: 0.2,
      maxScale: 4.0,
      child: HexagonGrid(
        hexType: type,
        depth: depth,
        buildChild: (coordinates) => GestureDetector(
          onTap: calculateEmotionText(coordinates.q, coordinates.r) == null
              ? () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(''),
                      content: Text(
                        calculateEmotionDescription(
                          coordinates.q,
                          coordinates.r,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  )
              : () {
                  widget.recordType == "diary"
                      ? ref
                          .read(dailyFormProvider.notifier)
                          .onPrimaryEmotionSelect(
                            calculateEmotionText(
                              coordinates.q,
                              coordinates.r,
                            )!,
                          )
                      : print('todo');
                  context.pushNamed(
                    AppRoutesName.secondaryEmotions,
                    pathParameters: {
                      'recordType': widget.recordType,
                      'emotion': calculateEmotionText(
                            coordinates.q,
                            coordinates.r,
                          )?.name ??
                          '',
                    },
                  );
                },
          onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                calculateEmotionText(coordinates.q, coordinates.r)?.name ?? '',
              ),
              content: Text(
                calculateEmotionDescription(coordinates.q, coordinates.r),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          child: HexagonWidget(
            height: 100.0,
            inBounds: false,
            color: calculateColor(coordinates.q, coordinates.r),
            padding: 2.0,
            cornerRadius: 8.0,
            elevation: 10.0,
            type: type,
            child: calculateEmotionText(coordinates.q, coordinates.r) == null
                ? const Icon(
                    Icons.info,
                    size: 40.0,
                    color: Colors.brown,
                  )
                : FittedBox(
                    child: Text(
                      calculateEmotionText(coordinates.q, coordinates.r)!.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
          ),
        ),
        buildTile: (coordinates) => HexagonWidgetBuilder(
          color: calculateColor(coordinates.q, coordinates.r),
          padding: 2.0,
          cornerRadius: 8.0,
          elevation: 10.0,
          child: Container(),
          // Text('${coordinates.x}, ${coordinates.y}, ${coordinates.z}\n  ${coordinates.q}, ${coordinates.r}'),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
