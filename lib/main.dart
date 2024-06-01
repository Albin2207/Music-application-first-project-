import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/database/playlist_db.dart';
import 'package:muscify_app/funtions/favorites_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/funtions/recent_db.dart';
import 'package:muscify_app/funtions/song_changing.dart';
import 'package:muscify_app/funtions/song_db.dart';
import 'package:muscify_app/screens/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter<Music>(MusicAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());

  // Open boxes
  await Hive.openBox<Music>('musicbox');
  await Hive.openBox<int>('favoriteBox');
  await Hive.openBox<Playlist>('playlistBox');
  await Hive.openBox<int>('recentlyBox');
  
  // Initialize just_audio_background
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Music? randomMusic;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
    if (_hasPermission) {
      List<SongModel> songModel = await _audioQuery.querySongs();
      await AddSongsToHive.addSongToHive(changeSongModel(songModel));
      await FavoriteFunctions.readFavSongs();
      await PlaylistFunc.getPlaylist();
      await RecentlyFunctions.readRecentSongs();
      final random = Random();
      randomMusic = songsNotifier.value[random.nextInt(songsNotifier.value.length)];
    }

    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Splashscreen(),
      ),
    );
  }
}