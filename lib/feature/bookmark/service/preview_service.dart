import 'package:dio/dio.dart';
import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/feature/bookmark/model/bookmark_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

/// Сервис который получает open graph данные и фавикон по ссылке
final class PreviewService {
  final Dio _dio;

  PreviewService({required Dio dio}) : _dio = dio;

  //* Метод для добавления og и фавикона в модель закладки
  Future<BookmarkModel?> addPreviewData(BookmarkModel bookmark) async {
    try {
      final response = await _dio.get(bookmark.url);
      final document = parse(response.data);

      final ogTitle = _extractMetaContent(document, 'og:title') ??
          document.head?.querySelector('title')?.text;
      final ogDescription = _extractMetaContent(document, 'og:description') ??
          _extractMetaContent(document, 'description');
      final ogImage = _extractMetaContent(document, 'og:image');
      final ogSiteName = _extractMetaContent(document, 'og:site_name');

      String? favicon = _constructFaviconUrl(bookmark.url);

      return bookmark.copyWith(
          ogTitle: ogTitle ?? '',
          ogDescription: ogDescription ?? '',
          ogImage: ogImage ?? '',
          ogSiteName: ogSiteName ?? '',
          favicon: favicon);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }

  String? _extractMetaContent(Document document, String property) {
    final metaTag = document.head
        ?.querySelectorAll('meta[property="$property"]')
        .firstOrNull;
    return metaTag?.attributes['content'];
  }

  String _constructFaviconUrl(String originalUrl) {
    try {
      Uri uri = Uri.parse(originalUrl);
      String domain = uri.host;

      return 'http://www.google.com/s2/favicons?domain=$domain&sz=64';
    } catch (e) {
      return '';
    }
  }
}
