import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmotionCard extends ConsumerWidget {
  final String? primaryEmotion;
  final String secondaryEmotion;
  final String? description;
  final Color primaryColor;
  final Color bgColor;
  final Color textColor;
  final void Function() onTap;
  const EmotionCard({
    super.key,
    this.primaryEmotion,
    this.description,
    required this.secondaryEmotion,
    required this.primaryColor,
    required this.bgColor,
    required this.onTap,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context, ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final String titleText = primaryEmotion != null
        ? '$primaryEmotion, $secondaryEmotion'
        : secondaryEmotion;
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor,
            width: 3,
          ),
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
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
                    children: <Widget>[
                      Text(
                        titleText,
                        style: TextStyle(
                          color: textColor,
                          fontSize: textTheme.titleLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              primaryColor,
                            ),
                          ),
                          onPressed: onTap,
                          child: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              description != null
                  ? IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(secondaryEmotion),
                            content: Text(description!),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  foregroundColor: appColors.error,
                                ),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      ),
                      icon: const Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
