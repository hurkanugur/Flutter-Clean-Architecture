enum ClientExceptionType {
  unexpectedFailureTypeError('UNEXPECTED_FAILURE_TYPE_ERROR'),
  translationNotFoundError('TRANSLATION_NOT_FOUND_ERROR'),
  translationUpdateError('TRANSLATION_UPDATE_ERROR'),
  colorNotFoundError('COLOR_NOT_FOUND_ERROR'),
  enumNotFoundError('ENUM_NOT_FOUND_ERROR'),
  noInternetConnectionError('NO_INTERNET_CONNECTION_ERROR'),
  databaseNotFoundError('DATABASE_NOT_FOUND_ERROR'),
  fileNotFoundError('FILE_NOT_FOUND_ERROR'),
  unexpectedDataTypeException('UNEXPECTED_DATA_TYPE_EXCEPTION'),
  unknownException('UNKNOWN_EXCEPTION'),
  webCertificateCouldNotBeLoaded('WEB_CERTIFICATE_COULD_NOT_BE_LOADED');

  final String name;

  const ClientExceptionType(this.name);
}
