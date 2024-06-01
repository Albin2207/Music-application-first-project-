import 'package:muscify_app/database/music_db.dart';
import 'package:on_audio_query/on_audio_query.dart';


List<Music> changeSongModel(List<SongModel> songModel) {
    List<Music> songs = [];
    for (var song in songModel) {
      songs.add(
        Music(
          id: song.id,
          title: song.title,
          artist: song.artist!,
          path: song.data,
        ),
      );
    }
    return songs;
  }