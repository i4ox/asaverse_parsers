import 'package:asaverse_parsers/core/failures/empty_element_failure.dart';
import 'package:asaverse_parsers/core/failures/found_element_failure.dart';
import 'package:asaverse_parsers/core/failures/html_failure.dart';
import 'package:asaverse_parsers/core/failures/parse_failure.dart';
import 'package:asaverse_parsers/core/manga_parser.dart';
import 'package:asaverse_parsers/core/utils/string_utils.dart';
import 'package:asaverse_parsers/models/manga.dart';
import 'package:asaverse_parsers/models/status.dart';
import 'package:asaverse_parsers/models/tag.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

final class DesuMeParser extends MangaParser {
  final domain = 'desu.me';
  final Dio client = Dio();

  @override
  Future<List<Manga>> getMangaList(
    Set<Tag>? tags,
    Set<Tag>? excludeTags,
  ) async {
    Uri uri = Uri.parse('https://$domain/manga/api');
    uri = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'limit': '20',
      },
    );

    if (tags != null && tags.isNotEmpty) {
      uri = uri.replace(
        queryParameters: {
          ...uri.queryParameters,
          'genres': tags.map((final tag) => tag.key).join(','),
        },
      );
    }

    final parsedUrl = uri.toString();
    print(parsedUrl);

    // Get the list of manga
    final json = (await client.get(parsedUrl)).data['response'];
    if (json == null) throw ParseFailure('Invalid response: $parsedUrl');

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
        tags: tags,
        score: manga['score'],
        status: Status.ongoing,
        chapters: {},
        description: manga['description'],
      ));
    }

    return list;
  }

  @override
  Future<Set<Tag>> fetchTags() async {
    final response = (await client.get('https://$domain/manga/'));
    final document = parse(response.data);

    // Parse the root element
    final root = document
        .getElementById('animeFilter')
        ?.querySelector('.catalog-genres');
    if (root == null) {
      throw HtmlFailure(
          'Element with id "animeFilter" or class "catalog-genres" not found');
    }

    // Parse the elements with tags
    final liElements = root.querySelectorAll('li');

    // Create the set with tags
    final Set<Tag> tags = {};
    for (Element li in liElements) {
      final input = li.querySelector('input');

      if (input == null) {
        throw FoundElementFailure('Input element not found in li');
      }

      final key = input.attributes['data-genre-slug']?.trim();
      final title = input.attributes['data-genre-name']?.trim();

      if (key == null || key.isEmpty) {
        throw EmptyElementFailure('data-genre-slug is empty');
      }

      if (title == null || title.isEmpty) {
        throw EmptyElementFailure('data-genre-name is empty');
      }

      final tag = Tag(
        key: key,
        title: StringUtils.toTitleCase(title),
      );

      tags.add(tag);
    }

    return tags;
  }
}
