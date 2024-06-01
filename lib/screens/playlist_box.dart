import 'package:flutter/material.dart';
import 'package:muscify_app/database/playlist_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/screens/addsongs_playlist.dart';
import 'package:muscify_app/screens/nowplaying_screen.dart';
import 'package:muscify_app/widgets/leading_image.dart';
import 'package:muscify_app/widgets/popup_playlist.dart';
import 'package:muscify_app/widgets/all_colors.dart';

class PlaylistEachFolder extends StatefulWidget {
  final Playlist playlistObj;
  final int playlistindex;
  const PlaylistEachFolder({super.key, required this.playlistObj, required this.playlistindex});

  @override
  State<PlaylistEachFolder> createState() => _PlaylistEachFolderState();
}

class _PlaylistEachFolderState extends State<PlaylistEachFolder> {
  late Playlist playlist;

  @override
  void initState() {
    super.initState();
    playlist = widget.playlistObj;
  }

  Future<void> _refreshPlaylist() async {
    final updatedPlaylist = PlaylistFunc.playlistBox.getAt(widget.playlistindex);
    setState(() {
      playlist = updatedPlaylist!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: itemscolor),
          onPressed: () => Navigator.pop(context),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            widget.playlistObj.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 70,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 28, 107, 116),
              Color(0xFF2C5364)
            ],
          ),
        ),
        child: playlist.songs.isEmpty
            ? const Center(
                child: Text(
                  "No songs in this Playlist!",
                  style: TextStyle(color: itemscolor, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: playlist.songs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayScreen(
                          musicObj: playlist.songs[index],
                          currentIndex: index,
                        ),
                      ),
                    ),
                    leading: LeadingImage(id: playlist.songs[index].id),
                    title: Text(
                      playlist.songs[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: itemscolor),
                    ),
                    subtitle: Text(
                      playlist.songs[index].artist!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: itemscolor),
                    ),
                    trailing: PlaylistPopUp(
                      musicObj: playlist.songs[index],
                      playlistIndex: widget.playlistindex,
                      songIndex: index,
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllSongsScreen(playlistIndex: widget.playlistindex),
            ),
          );
          if (result == true) {
            _refreshPlaylist();
          }
        },
        child: const Icon(
          Icons.add,
          color: labelcolor,
        ),
      ),
    );
  }
}
