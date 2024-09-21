class Emotion {
  final String name;
  final String description;
  final String color;
  final EmotionTheme colorBrightness;

  Emotion({
    required this.name,
    required this.description,
    required this.color,
    required this.colorBrightness,
  });

  factory Emotion.empty() {
    return Emotion(
      name: '',
      description: '',
      color: '',
      colorBrightness: EmotionTheme.LIGHT,
    );
  }
}

enum EmotionTheme { DARK, LIGHT }
