import 'package:flutter/material.dart';

class EmotionCard extends StatelessWidget {
  final String? primaryEmotion;
  final String secondaryEmotion;
  final Color primaryColor;
  final Color bgColor;
  final Color buttonTextColor;

  const EmotionCard({
    super.key,
    this.primaryEmotion,
    required this.secondaryEmotion,
    required this.primaryColor,
    required this.bgColor,
    this.buttonTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String titleText = primaryEmotion != null
        ? '$primaryEmotion, $secondaryEmotion'
        : secondaryEmotion;
    return Card(
      color: bgColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(17),
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
                        style: textTheme.titleMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              primaryColor,
                            ),
                          ),
                          onPressed: () => print('Select Emotion'),
                          child: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: buttonTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => print('info'),
                icon: const Icon(
                  Icons.info_outline,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
