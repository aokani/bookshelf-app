import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:logging/logging.dart';
import 'dart:core';

class ApiService {
  static const String baseUrl = 'https://iss.ndl.go.jp/api/opensearch';
  static final Logger _log = Logger('ApiService');

  static Future<List<Map<String, dynamic>>> searchBooksByTitle(String title) async {
    _log.info('書籍検索開始: タイトル = $title');

    final encodedTitle = Uri.encodeComponent(title);
    final Uri uri = Uri.parse('$baseUrl?title=$encodedTitle&mediatype=booklet');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        List<Map<String, dynamic>> searchResults = [];
        for (final item in items) {
          final dcTitleElement = item.findElements('dc:title').firstOrNull;
          final dcTitle = dcTitleElement?.innerText ?? 'タイトル不明';

          final volumeElement = item.findElements('dcndl:volume').firstOrNull;
          final volume = volumeElement?.innerText;

          final title = volume != null ? '$dcTitle 第$volume巻' : dcTitle;

          final creators = item.findElements('dc:creator').map((e) => e.innerText).toList();
          final author = creators.isNotEmpty
              ? creators.join('\n')
              : item.findElements('author').map((e) => e.innerText).join('\n') ?? '著者不明'; // 著者を改行区切りで結合

          final publisherElement = item.findElements('dc:publisher').firstOrNull;
          final publisher = publisherElement?.innerText ?? '出版社不明';

          final issuedElement = item.findElements('dcterms:issued').firstOrNull;
          final issued = issuedElement?.innerText ?? '';

          final genreElement = item.findElements('dcndl:genre').firstOrNull;
          final genre = genreElement?.innerText ?? '';

          searchResults.add({
            'title': title,
            'author': author,
            'publisher': publisher,
            'filteringData': {
              'issued': issued,
              'genre': genre,
            },
          });
        }

        _log.info('書籍検索完了: ${searchResults.length}件');
        return searchResults;
      } else {
        _log.warning('APIリクエスト失敗: ステータスコード = ${response.statusCode}, body = ${response.body}');
        return [];
      }
    } on http.ClientException catch (e) {
      _log.severe('HTTPリクエストエラー: $e');
      return [];
    } catch (e) {
      _log.severe('予期せぬエラー: $e');
      return [];
    }
  }
}
