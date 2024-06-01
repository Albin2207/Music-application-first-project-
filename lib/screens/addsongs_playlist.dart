import 'package:flutter/material.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsScreen extends StatelessWidget {
  final int playlistIndex;

  const AllSongsScreen({Key? key, required this.playlistIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: itemscolor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Songs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: bgcolor,
        child: ValueListenableBuilder(
          valueListenable: songsNotifier,
          builder: (context, List<Music> songs, child) {
            if (songs.isEmpty) {
              return const Center(
                child: Text(
                  "No songs available",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final Music song = songs[index];
                return ListTile(
                  onTap: () async {
                    await PlaylistFunc.addSongToPlaylist(playlistIndex, song, context);
                    Navigator.pop(context, true); // Return true when song is added
                  },
                  title: Text(
                    song.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song.artist ?? 'Unknown Artist',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  leading: QueryArtworkWidget(id: song.id, type: ArtworkType.AUDIO),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
