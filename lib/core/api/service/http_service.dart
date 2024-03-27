import 'dart:io';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/error/model/server_failure.dart';
import 'package:clean_architecture/config/app_resources.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/services.dart';

class HttpService {
  final Dio _dio;
  final CookieManager _cookieManager;

  const HttpService({
    required Dio dio,
    required CookieManager cookieManager,
  })  : _dio = dio,
        _cookieManager = cookieManager;

  /// Creates an instance of this class.
  static Future<HttpService> createInstance() async {
    final BaseOptions timeoutOptions = BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );

    final Dio dio = Dio(timeoutOptions);

    final CookieManager cookieManager = CookieManager(CookieJar());

    final SecurityContext securityContext = SecurityContext.defaultContext;

    await _loadWebCertificates(securityContext: securityContext);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => HttpClient(context: securityContext),
    );

    dio.interceptors.add(cookieManager);

    return HttpService(dio: dio, cookieManager: cookieManager);
  }

  /// Load and trust the web certificates.
  static Future<void> _loadWebCertificates({required SecurityContext securityContext}) async {
    for (String webCertificatePath in AppResources.webCertificatePaths) {
      try {
        final ByteData certificateData = await rootBundle.load(webCertificatePath);
        securityContext.setTrustedCertificatesBytes(certificateData.buffer.asUint8List());
        StackTrace.current.printSuccessMessage(message: '$webCertificatePath certificate is trusted successfully.');
      } catch (errorOrException) {
        StackTrace.current.printErrorMessage(
          failure: ClientFailure(
            stackTrace: StackTrace.current,
            thrownErrorOrException: errorOrException,
            clientExceptionType: ClientExceptionType.webCertificateCouldNotBeLoaded,
          ),
        );
      }
    }
  }

  /// Performs a GET request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a POST request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> postRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a PUT request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> putRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a DELETE request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> deleteRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a custom HTTP request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> customRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.request(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Prints the cookies saved on the [url] parameter.
  Future<void> printCookies({required String url}) async {
    List<Cookie> cookies = await _cookieManager.cookieJar.loadForRequest(Uri.parse(url));

    for (Cookie cookie in cookies) {
      StackTrace.current.printSuccessMessage(message: '${cookie.name}:${cookie.value}');
    }
  }

  /// Clear all cookies.
  Future<void> clearCookies() async {
    await _cookieManager.cookieJar.deleteAll();
  }
}
