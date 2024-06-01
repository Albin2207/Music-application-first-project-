import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';


ValueNotifier<List<Music>> favoriteNotifier = ValueNotifier([]);
class FavoriteFunctions extends ChangeNotifier{
  // hive reference
  static final favoriteBox = Hive.box<int>('favoriteBox'); 
  // add to favorite
  static Future<void> addToFavorite({required Music song})async {
    await favoriteBox.add(song.id);
    favoriteNotifier.value.add(song);
    favoriteNotifier.notifyListeners();
  }
  // remove from favorite
  static Future<void> deleteFromFav(int songId)async{
    int deleteKey = 0;
    if(!favoriteBox.values.contains(songId)){
      return;
    }
    final Map<dynamic, int> favorMap = favoriteBox.toMap();
    favorMap.forEach((key, value) {
      if(value == songId){
        deleteKey = key;
      }
    }); 
    await favoriteBox.delete(deleteKey);
    await readFavSongs();
  }
  // read all songs from favorite
  static Future<void> readFavSongs()async {
    favoriteNotifier.value.clear();
    for(var song in songsNotifier.value){
      if(isFavor(song)){
        favoriteNotifier.value.add(song);
      }
    }
    favoriteNotifier.notifyListeners();
  }
  static bool isFavor(Music song){
    if(favoriteBox.values.contains(song.id)){
      return true;
    }
    return false;
  }
}