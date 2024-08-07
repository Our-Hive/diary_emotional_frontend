class InvalidEmotionSelectedException implements Exception {
  final String message;

  InvalidEmotionSelectedException({
    this.message = 'Emoción seleccionada invalidad',
  });
}
