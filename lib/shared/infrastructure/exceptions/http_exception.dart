class HttpException implements Exception {
  final String message;

  HttpException({
    this.message =
        'Ha ocurrido un error en la petición HTTP. Inténtelo de nuevo más tarde.',
  });
}
