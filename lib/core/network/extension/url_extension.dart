import 'package:clean_architecture/config/app_regex.dart';

extension URLExtension on String {
  /// Converts the given [url] to a secure URL.
  static String convertToSecureURL({required String url}) {
    if (url.startsWith('http://')) {
      url = url.replaceFirst('http://', 'https://');
    } else if (!url.startsWith('https://')) {
      url = 'https://$url';
    }
    return url;
  }

  /// Converts Youtube video link to embedded video link.
  static String? convertYoutubeVideoLinkToEmbedded({required String youTubeLink}) {
    String? videoId;

    videoId = AppRegex.embeddedYouTubeVideoLinkRegExp.firstMatch(youTubeLink)?.group(0)?.split('/').last;

    videoId ??= AppRegex.normalYouTubeVideoLinkRegExp.firstMatch(youTubeLink)?.group(0)?.split('v=').last;

    videoId ??= AppRegex.sharingYouTubeVideoLinkRegExp.firstMatch(youTubeLink)?.group(0)?.split('/').last;

    if (videoId != null) {
      if (youTubeLink.startsWith('http://')) {
        return "http://www.youtube.com/embed/$videoId";
      } else {
        return "https://www.youtube.com/embed/$videoId";
      }
    }

    return null;
  }

  /// Converts Vimeo video link to embedded video link.
  static String? convertVimeoVideoLinkToEmbedded({required String vimeoLink}) {
    String? videoId;

    videoId = AppRegex.embeddedVimeoVideoLinkRegExp.firstMatch(vimeoLink)?.group(0)?.split('/').last;

    videoId ??= AppRegex.normalVimeoVideoLinkRegExp.firstMatch(vimeoLink)?.group(0)?.split('/').last;

    if (videoId != null) {
      if (vimeoLink.startsWith('http://')) {
        return "http://player.vimeo.com/video/$videoId";
      } else {
        return "https://player.vimeo.com/video/$videoId";
      }
    }

    return null;
  }

  /// Converts DailyMotion video link to embedded video link.
  static String? convertDailyMotionVideoLinkToEmbedded({required String dailyMotionLink}) {
    String? videoId;

    videoId = AppRegex.embeddedDailyMotionVideoLinkRegExp.firstMatch(dailyMotionLink)?.group(0)?.split('/').last;

    videoId ??= AppRegex.normalDailyMotionVideoLinkRegExp.firstMatch(dailyMotionLink)?.group(0)?.split('/').last;

    videoId ??= AppRegex.sharingDailyMotionVideoLinkRegExp.firstMatch(dailyMotionLink)?.group(0)?.split('/').last;

    if (videoId != null) {
      if (dailyMotionLink.startsWith('http://')) {
        return "http://www.dailymotion.com/embed/video/$videoId";
      } else {
        return "https://www.dailymotion.com/embed/video/$videoId";
      }
    }

    return null;
  }
}
