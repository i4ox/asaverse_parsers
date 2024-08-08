import 'package:asaverse_parsers/core/exceptions/parse_exception.dart';
import 'package:asaverse_parsers/core/manga_parser.dart';
import 'package:asaverse_parsers/models/manga.dart';
import 'package:asaverse_parsers/models/status.dart';
import 'package:dio/dio.dart';

final class DesuMeParser extends MangaParser {
  @override
  Future<List<Manga>> getMangaList() async {
    final Dio client = Dio();
    final domain = 'desu.me';
    final url = 'https://$domain/manga/api?limit=20';

    // Get the list of manga
    final json = (await client.get(url)).data['response'];
    if (json == null) throw ParseException('Invalid response: $url');

    // Create list of manga models
    List<Manga> list = [];
    for (int i = 0; i < 20; i++) {
      // Get the manga
      final manga = json[i];

      // Add the manga to result list
      list.add(Manga(
        id: manga['id'],
        title: manga['name'],
        altTitle: manga['russian'],
        coverUrl: manga['image']['preview'],
        url: '/manga/api/${manga['id']}',
        tags: {},
        score: manga['score'],
        status: Status.ongoing,
        chapters: {},
        description: manga['description'],
      ));
    }

    return list;
  }
}
