import 'package:asaverse_parsers/core/manga_parser.dart';
import 'package:asaverse_parsers/models/manga.dart';
import 'package:asaverse_parsers/parsers/desu_me/desu_me_parser.dart';

void main() async {
  final MangaParser parser = DesuMeParser();
  final List<Manga> mangaList = await parser.getMangaList();
  for (Manga manga in mangaList) {
    print(manga.altTitle);
  }
}
