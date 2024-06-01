import 'package:hive/hive.dart';
import 'package:muscify_app/database/music_db.dart';

 part 'playlist_db.g.dart';

@HiveType(typeId: 1)
class Playlist extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Music> songs;

  Playlist({required this.name,required this.songs});
}
