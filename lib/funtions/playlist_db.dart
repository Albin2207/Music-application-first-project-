import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/database/playlist_db.dart';
import 'package:muscify_app/widgets/snackbar_message.dart';


ValueNotifier<List<Playlist>> playlistNotifier = ValueNotifier([]);

class PlaylistFunc extends ChangeNotifier {
  
  static final playlistBox = Hive.box<Playlist>('playlistBox');

  static Future<void> createPlaylistFolder(
    String name) async {
    final playlist = Playlist(songs: [], name: name);
    await playlistBox.add(playlist);
    playlistNotifier.value.add(playlist);
    playlistNotifier.notifyListeners();
  }

  static Future<void> getPlaylist() async { 
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistBox.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    playlistBox.deleteAt(index);
    playlistNotifier.value.removeAt(index);
    playlistNotifier.notifyListeners();
  }

  static Future<void> addSongToPlaylist(
      int index, Music song, BuildContext context) async {
    final playlist = playlistBox.getAt(index);
    if (playlist!.songs.contains(song)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Already Added!'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
        ),
      );
      return;
    }
    playlist.songs.add(song);
    await playlistBox.putAt(index, playlist);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
    if (context.mounted) showSnackbar(context);

  }

  static Future<void> updateFolderName(
      int index, String name) async {
    final playlist = playlistBox.getAt(index);
    playlist!.name = name;
    await playlistBox.putAt(index, playlist);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
  }

  static Future<void> deleteSongFromPlaylist(int index, int songIndex) async {
    final playlistFolder = playlistBox.getAt(index);
    playlistFolder!.songs.removeAt(songIndex);
    await playlistBox.putAt(index, playlistFolder);
    playlistNotifier.value = playlistBox.values.toList();
    playlistNotifier.notifyListeners();
  }
}
