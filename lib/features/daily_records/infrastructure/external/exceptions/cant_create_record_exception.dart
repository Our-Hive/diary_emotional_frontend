class CantCreateRecordException implements Exception {
  final String message;

  CantCreateRecordException({
    this.message = 'No se pudo crear el registro de emoción',
  });
}
