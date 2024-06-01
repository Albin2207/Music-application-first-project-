import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';

ValueNotifier<List<Music>> recentlyNotifier = ValueNotifier([]);

class RecentlyFunctions extends ChangeNotifier {
  // hive reference
  static final recentlyBox = Hive.box<int>('recentlyBox');

  // add to recent
  static Future<void> addToRecentlyPlayed(Music song) async {
    recentlyBox.delete(recentlyBox.values.toList().indexOf(song.id));
    // remove duplicate
    recentlyNotifier.value.remove(song);
    await recentlyBox.add(song.id);
    recentlyNotifier.value.add(song);
    if (recentlyNotifier.value.length > 10) {
      recentlyNotifier.value.removeAt(0);
    await recentlyBox.deleteAt(0);  
    }
    recentlyNotifier.notifyListeners();
  }

  // read all songs from recent
  static Future<void> readRecentSongs() async {
    recentlyNotifier.value.clear();
    for (var song in songsNotifier.value) {
      if (isRecent(song)) {
        recentlyNotifier.value.add(song);
      }
    }
    recentlyNotifier.notifyListeners();
  }

  static bool isRecent(Music song) {
    if (recentlyBox.values.contains(song.id)) {
      return true;
    }
    return false;
  }
}
