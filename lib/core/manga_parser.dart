import 'package:asaverse_parsers/models/manga.dart';
import 'package:asaverse_parsers/models/tag.dart';

abstract class MangaParser {
  Future<List<Manga>> getMangaList(Set<Tag>? tags, Set<Tag>? excludeTags);
  Future<Set<Tag>> fetchTags();
}
