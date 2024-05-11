import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

class EmotionalRoulette extends StatelessWidget {
  final HexagonType type = HexagonType.FLAT;
  final int depth = 1;
  //final Set<Emotion> emotions;

  const EmotionalRoulette({super.key});

  String calculateEmotionText(int q, int r) {
    if (q == 1 && r == 0) {
      return 'Felicidad';
    } else if (q == 1 && r == -1) {
      return 'Asco';
    } else if (q == 0 && r == -1) {
      return 'Tristeza';
    } else if (q == -1 && r == 0) {
      return 'Miedo';
    } else if (q == -1 && r == 1) {
      return 'Sorpresa';
    } else if (q == 0 && r == 1) {
      return 'Ira';
    }
    return '';
  }

  String calculateEmotionDescription(int q, int r) {
    if (q == 1 && r == 0) {
      return 'Felicidad';
    } else if (q == 1 && r == -1) {
      return 'Asco';
    } else if (q == 0 && r == -1) {
      return 'Tristeza';
    } else if (q == -1 && r == 0) {
      return 'Miedo';
    } else if (q == -1 && r == 1) {
      return 'Sorpresa';
    } else if (q == 0 && r == 1) {
      return 'Ira';
    }
    return '';
  }

  Color calculateColor(int q, int r) {
    if (q == 1 && r == 0) {
      return Colors.yellow.shade300;
    } else if (q == 1 && r == -1) {
      return Colors.green.shade300;
    } else if (q == 0 && r == -1) {
      return Colors.blue.shade300;
    } else if (q == -1 && r == 0) {
      return Colors.purple.shade300;
    } else if (q == -1 && r == 1) {
      return Colors.pink.shade300;
    } else if (q == 0 && r == 1) {
      return Colors.red.shade400;
    }
    return Colors.orange.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.2,
      maxScale: 4.0,
      child: HexagonGrid(
        hexType: type,
        depth: depth,
        buildChild: (coordinates) => GestureDetector(
          onTap: calculateEmotionText(coordinates.q, coordinates.r).isEmpty
              ? null
              : () {
                  print(
                    'Select Emotion: ${calculateEmotionText(coordinates.q, coordinates.r)}',
                  );
                },
          onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                calculateEmotionText(coordinates.q, coordinates.r),
              ),
              content: Text(
                calculateEmotionText(coordinates.q, coordinates.r).isEmpty
                    ? 'Este es el panel de emociones primarias, puedes seleccionar alguna que este a mi al rededor la cual exprese lo mejor posible lo que sientes en estos momentos.\n\nSi tienes alguna duda sobre alguna emoción, puedes mantener la emoción para obtener más información.'
                    : calculateEmotionText(coordinates.q, coordinates.r),
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
            child: calculateEmotionText(coordinates.q, coordinates.r).isEmpty
                ? const Icon(
                    Icons.info,
                    size: 40.0,
                    color: Colors.black,
                  )
                : Text(
                    calculateEmotionText(coordinates.q, coordinates.r),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
