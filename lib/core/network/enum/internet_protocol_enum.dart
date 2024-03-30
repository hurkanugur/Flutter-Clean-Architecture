import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

enum InternetProtocol {
  http,
  https;

  const InternetProtocol();

  /// Creates a [InternetProtocol] from [index].
  ///
  /// Returns `null` when the enum is not found.
  static InternetProtocol? getInternetProtocolByIndex({required int? index}) {
    try {
      return values.firstWhere((element) => element.index == index);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
    return null;
  }
}
