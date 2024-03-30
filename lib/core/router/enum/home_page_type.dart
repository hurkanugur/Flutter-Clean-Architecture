import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum HomePageType {
  weather,
  weatherDetails,
  settings;

  const HomePageType();

  /// Creates a [HomePageType] from [index].
  ///
  /// Throws [ClientFailure] when an error occurs.
  static HomePageType? getHomePageTypeByIndex({required int? index}) {
    if (index == null) {
      return null;
    }

    try {
      return values.firstWhere((element) => element.index == index);
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
