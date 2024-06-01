import 'package:hive/hive.dart';

 part 'music_db.g.dart';

@HiveType(typeId:0)
class Music extends HiveObject{

  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? artist;

  @HiveField(3)
  final String path;

  Music({required this.id, required this.path, required this.title, this.artist,});

  get artwork => null;

  get artworkPath => null;
}