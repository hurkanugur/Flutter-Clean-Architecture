import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:clean_architecture/config/app_regex.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/platform_channel/service/platform_channel_downloader_service.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryService {
  final PlatformChannelDownloaderService _platformChannelDownloaderService;

  const DirectoryService({
    required PlatformChannelDownloaderService platformChannelDownloaderService,
  }) : _platformChannelDownloaderService = platformChannelDownloaderService;

  /// Returns the size of Application Documents Directory.
  ///
  /// Returns `0` when the operation fails.
  Future<int> getApplicationDocumentsDirectorySize() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      int size = 0;

      final List<FileSystemEntity> systemEntities = appDocDir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in systemEntities) {
        if (entity is File) {
          size += await entity.length();
        }
      }

      return size;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryFetchSizeOperationError,
        exception: ex,
      );
    }

    return 0;
  }

  /// Returns the size of Temporary Directory.
  ///
  /// Returns `0` when the operation fails.
  Future<int> getTemporaryDirectorySize() async {
    try {
      await createTemporaryDirectoryIfNotExists();

      final Directory tempDir = await getTemporaryDirectory();
      int size = 0;

      final List<FileSystemEntity> systemEntities = tempDir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in systemEntities) {
        if (entity is File) {
          size += await entity.length();
        }
      }

      return size;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryFetchSizeOperationError,
        exception: ex,
      );
    }

    return 0;
  }

  /// Creates the Application Documents Directory if it does not exist.
  Future<void> createApplicationDocumentsDirectoryIfNotExists() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    try {
      if (!appDocDir.existsSync()) {
        appDocDir.createSync(recursive: true);
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryCreateOperationError,
        exception: ex,
      );
    }
  }

  /// Creates the Temporary Directory if it does not exist.
  Future<void> createTemporaryDirectoryIfNotExists() async {
    final Directory tempDir = await getTemporaryDirectory();

    try {
      if (!tempDir.existsSync()) {
        tempDir.createSync(recursive: true);
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryCreateOperationError,
        exception: ex,
      );
    }
  }

  /// Deletes the Temporary Directory which is used for storing caches.
  ///
  /// Returns `true` when the folder is deleted successfully.
  Future<bool> deleteTemporaryDirectory() async {
    try {
      final Directory temporaryDirectory = await getTemporaryDirectory();

      if (temporaryDirectory.existsSync()) {
        temporaryDirectory.deleteSync(recursive: true);
      }

      return true;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryDeleteOperationError,
        exception: ex,
      );
    }

    return false;
  }

  /// Deletes the Application Documents Folder used for pesistent data storage.
  ///
  /// Returns `true` when the folder is deleted successfully.
  Future<bool> deleteApplicationDocumentsFolder() async {
    try {
      final Directory applicationDocumentsDirectory = await getApplicationDocumentsDirectory();

      if (applicationDocumentsDirectory.existsSync()) {
        applicationDocumentsDirectory.deleteSync(recursive: true);
      }

      return true;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deviceDirectoryDeleteOperationError,
        exception: ex,
      );
    }

    return false;
  }

  /// Reads the data from assets folder.
  ///
  /// Returns `null` when the operation fails.
  Future<ByteData?> readDataFromAssetsFolder({required String dataPath}) async {
    try {
      return await rootBundle.load(dataPath);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileReadOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to save files in a publicly accessible places.
  ///
  /// Returns `true` when the operation succeeds.
  ///
  /// `Android`: The file is stored in Downloads Directory.
  ///
  /// `iOS`: The location is selected by the user.
  ///
  /// `Example`: [fileName] can be given as 'test.txt' or 'test.png' etc.
  ///
  /// `Note`: Storage Access Permission is required before calling this method.
  Future<bool> savePublicMediaFile({
    required String fileName,
    required String base64Data,
  }) async {
    try {
      fileName = _validateFileNameCharacters(fileName: fileName);
      fileName = _addDateTimeInToFileName(fileName: fileName);

      final Uint8List data = const Base64Decoder().convert(base64Data);
      final String mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
      final bool isDownloadSuccessful = await _platformChannelDownloaderService.download(
        fileName: fileName,
        data: data,
        mimeType: mimeType,
      );

      if (isDownloadSuccessful) {
        return true;
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileWriteOperationError,
        exception: ex,
      );
    }

    return false;
  }

  /// This method is used to preview a file without downloading it.
  ///
  /// Returns [ResultType] which represents the operation result.
  ///
  /// The data is stored in the platform's temporary cache folder, where the data is not persistent.
  ///
  /// [fileName] can be given as 'test.txt' or 'test.png' etc.
  Future<ResultType> previewMediaFile({
    required String fileName,
    required String base64Data,
  }) async {
    try {
      fileName = _validateFileNameCharacters(fileName: fileName);
      fileName = _addDateTimeInToFileName(fileName: fileName);

      final Uint8List data = const Base64Decoder().convert(base64Data);

      await createTemporaryDirectoryIfNotExists();

      final String directoryPath = (await getTemporaryDirectory()).path;
      final String fileLocation = '$directoryPath/$fileName';
      final File file = File(fileLocation);
      await file.writeAsBytes(data);

      final OpenResult openFileResult = await OpenFilex.open(fileLocation);

      if (openFileResult.type == ResultType.noAppToOpen) {
        ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.noApplicationFoundToOpenTheFileError,
          exception: openFileResult.message,
        );
      }

      return openFileResult.type;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileOpenOperationError,
        exception: ex,
      );
    }

    return ResultType.error;
  }

  /// This method is used to read file from the gallery.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Gallery Access Permission is required before calling this method.
  Future<Uint8List?> pickFileFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      final bool didUserSelectFile = (file == null) ? false : true;
      if (didUserSelectFile) {
        return await file.readAsBytes();
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileReadOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to take a photo, then read the image by using camera.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Camera Access Permission is required before calling this method.
  Future<Uint8List?> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.camera);
      final bool didUserTakePhoto = (file == null) ? false : true;
      if (didUserTakePhoto) {
        return await file.readAsBytes();
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileReadOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to read file from the documents and downloads folder.
  ///
  /// Returns `null` when the operation fails.
  ///
  /// `Note`: Storage Access Permission is required before calling this method.
  Future<Uint8List?> pickFileFromDocumentsAndDownloadsFolder() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      final bool didUserSelectFile = (result == null) ? false : true;
      if (didUserSelectFile) {
        final PlatformFile file = result.files.first;
        return file.bytes;
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileReadOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to write text files into a folder that the user cannot access.
  ///
  /// Returns the saved file path when the operation succeeds.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt'. (IT MUST BE A TEXT FILE).
  Future<String?> savePrivateTextFile({
    required String fileName,
    required String content,
  }) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String filePath = '$directoryPath/$fileName';
      final File file = File(filePath);
      await file.writeAsString(content);
      return fileName;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileWriteOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to read text files from a folder that the user cannot access.
  ///
  /// Returns the saved file path when the operation succeeds.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt'. (IT MUST BE A TEXT FILE).
  Future<String?> readPrivateTextFile({required String fileName}) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String externalFilePath = '$directoryPath/$fileName';
      final File file = File(externalFilePath);
      if (await file.exists() == true) {
        return await file.readAsString();
      }
      return null;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileWriteOperationError,
        exception: ex,
      );
    }

    return null;
  }

  /// This method is used to delete files from a folder that the user cannot access.
  ///
  /// The file is stored in a place under the Mobile Application's folder (It is hard for the user to find it).
  ///
  /// `Example`: [fileName] can be given as 'test.txt' or 'test.png' etc.
  Future<void> deletePrivateFile({required String fileName}) async {
    try {
      await createApplicationDocumentsDirectoryIfNotExists();

      final String directoryPath = (await getApplicationDocumentsDirectory()).path;
      final String externalFilePath = '$directoryPath/$fileName';
      final File file = File(externalFilePath);
      if (await file.exists() == true) {
        await file.delete();
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.fileDeleteOperationError,
        exception: ex,
      );
    }
  }

  /// This method is used to insert the [DateTime] to the filename so that the filename can be unique.
  ///
  /// [fileName] can be given as 'test.txt' or 'test.png' etc.
  String _addDateTimeInToFileName({required String fileName}) {
    final DateTime dateTime = DateTime.now();
    final int extensionIndex = fileName.lastIndexOf('.');
    final bool hasExtension = extensionIndex != -1 ? true : false;

    final String fileNameWithDateTime;

    if (hasExtension) {
      fileNameWithDateTime = '${fileName.substring(0, extensionIndex)}_${dateTime.millisecondsSinceEpoch}${fileName.substring(extensionIndex)}';
    } else {
      fileNameWithDateTime = '${fileName}_${dateTime.millisecondsSinceEpoch}';
    }

    return fileNameWithDateTime;
  }

  /// This method is used to replace all forbidden characters in the [fileName].
  ///
  /// Forbidden characters are given as \ / * : ? " < > | etc.
  String _validateFileNameCharacters({required String fileName}) {
    return fileName.replaceAll(AppRegex.forbiddenFileNameCharacterRegex, '_');
  }
}
