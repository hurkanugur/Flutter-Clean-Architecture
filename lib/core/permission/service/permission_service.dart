import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService();

  /// This is a mutex for permission request requests.
  bool _requestPermissionMutex = false;

  /// This method is used to check whether the [permission] access is granted or not.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> _requestPermission({
    required Permission permission,
    required TextType permissionMenuTitle,
    required TextType permissionMenuExplanationText,
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    if (_requestPermissionMutex) {
      return PermissionStatus.permanentlyDenied;
    }

    _requestPermissionMutex = true;

    final PermissionStatus permissionStatus = await permission.status;
    final bool isPermissionAlreadyGranted = isPermissionGranted(permissionStatus: permissionStatus);
    final bool isPermissionNeverAskedBefore = this.isPermissionNeverAskedBefore(permissionStatus: permissionStatus);

    if (isPermissionAlreadyGranted || !requestPermissionSilentlyOnDenied) {
      _requestPermissionMutex = false;
      return permissionStatus;
    }

    final PermissionStatus newPermissionStatus = await permission.request();
    final bool isNewPermissionGranted = isPermissionGranted(permissionStatus: newPermissionStatus);
    final bool isNewPermissionPermanentlyDenied = isPermissionDeniedPermanently(permissionStatus: newPermissionStatus);

    if (isNewPermissionGranted || !displayPermissionRequestMenuOnPermanentlyDenied || (isPermissionNeverAskedBefore && isNewPermissionPermanentlyDenied)) {
      _requestPermissionMutex = false;
      return newPermissionStatus;
    }

    // TODO Implement here in the future
    const PermissionStatus? menuPermissionStatus = null;
    /* await PermissionRequestMenu.displayMenu(
      menuTitle: permissionMenuTitle,
      explanationText: permissionMenuExplanationText,
      onDonePressed: () async {
        await openAppSettings();
      },
      onCancelPressed: () async {},
    ); */

    _requestPermissionMutex = false;
    return menuPermissionStatus;
  }

  /// Checks whether the permission is granted or not.
  bool isPermissionGranted({required PermissionStatus? permissionStatus}) {
    return permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited;
  }

  /// Checks whether the permission has ever been asked before or not.
  bool isPermissionNeverAskedBefore({required PermissionStatus? permissionStatus}) {
    return permissionStatus == PermissionStatus.denied;
  }

  /// Checks whether the permission is denied permanently or not.
  bool isPermissionDeniedPermanently({required PermissionStatus? permissionStatus}) {
    return permissionStatus == PermissionStatus.permanentlyDenied;
  }

  /// Checks whether the permission request is cancelled.
  bool isPermissionRequestCanceled({required PermissionStatus? permissionStatus}) {
    return permissionStatus == null;
  }

  /// Requests notification access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> requestNotificationAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    return await _requestPermission(
      permission: Permission.notification,
      permissionMenuTitle: TextType.notificationAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.notificationAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }

  /// Requests camera access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> requestCameraAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    return await _requestPermission(
      permission: Permission.camera,
      permissionMenuTitle: TextType.cameraAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.cameraAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }

  /// Requests calendar access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> requestCalendarAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    final Permission permission;

    if (Platform.isAndroid) {
      permission = Permission.calendarFullAccess;
    } else if (Platform.isIOS) {
      final bool ios17AndLater = int.parse((await DeviceInfoPlugin().iosInfo).systemVersion.split('.')[0]) >= 17 ? true : false;
      permission = ios17AndLater ? Permission.calendarFullAccess : Permission.calendarWriteOnly;
    } else {
      return PermissionStatus.permanentlyDenied;
    }

    return await _requestPermission(
      permission: permission,
      permissionMenuTitle: TextType.calendarAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.calendarAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }

  /// Requests storage access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> requestStorageAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    final Permission permission;

    if (Platform.isAndroid) {
      final int apiLevel = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      if (apiLevel < 33) {
        permission = Permission.storage;
      } else {
        return PermissionStatus.granted;
      }
    } else if (Platform.isIOS) {
      permission = Permission.storage;
    } else {
      return PermissionStatus.permanentlyDenied;
    }

    return await _requestPermission(
      permission: permission,
      permissionMenuTitle: TextType.storageAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.storageAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }

  /// Requests gallery access permission.
  ///
  /// If [requestPermissionSilentlyOnDenied] is [true], it asks permission if the permission is not granted.
  ///
  /// Otherwise it returns the result of whether the permission is granted or not.
  ///
  /// If [displayPermissionRequestMenuOnPermanentlyDenied] is true, it tries to ask permission by displaying Flutter-built menu.
  Future<PermissionStatus?> requestGalleryAccessPermission({
    required bool requestPermissionSilentlyOnDenied,
    required bool displayPermissionRequestMenuOnPermanentlyDenied,
  }) async {
    final Permission permission;

    if (Platform.isAndroid) {
      final int apiLevel = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      if (apiLevel < 33) {
        permission = Permission.storage;
      } else if (apiLevel >= 33) {
        permission = Permission.photos;
      } else {
        return PermissionStatus.granted;
      }
    } else if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      return PermissionStatus.permanentlyDenied;
    }

    return await _requestPermission(
      permission: permission,
      permissionMenuTitle: TextType.galleryAccessPermissionRequestTitle,
      permissionMenuExplanationText: TextType.galleryAccessPermissionRequestExplanation,
      requestPermissionSilentlyOnDenied: requestPermissionSilentlyOnDenied,
      displayPermissionRequestMenuOnPermanentlyDenied: displayPermissionRequestMenuOnPermanentlyDenied,
    );
  }
}
