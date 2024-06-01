import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';



class AddSongsToHive extends ChangeNotifier{
  static Future<void> addSongToHive(List<Music> songs) async{
    songsNotifier.value.clear();
    final box = Hive.box<Music>('musicbox');
    await box.addAll(songs); 
    songsNotifier.value.addAll(songs);
    songsNotifier.notifyListeners();
  }
}
