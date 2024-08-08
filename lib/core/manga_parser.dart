import 'package:asaverse_parsers/models/manga.dart';

abstract class MangaParser {
  Future<List<Manga>> getMangaList();
}
