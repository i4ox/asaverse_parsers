import 'package:asaverse_parsers/models/chapter.dart';
import 'package:asaverse_parsers/models/status.dart';
import 'package:asaverse_parsers/models/tag.dart';

final class Manga {
  final int id;
  final String title;
  final String? altTitle;
  final String coverUrl;
  final String url;
  final Status status;
  final double score;
  final Set<Tag>? tags;
  final Set<Chapter>? chapters;
  final String description;

  const Manga({
    required this.id,
    required this.title,
    this.altTitle,
    required this.coverUrl,
    required this.url,
    required this.status,
    required this.score,
    this.tags,
    this.chapters,
    required this.description,
  });
}
