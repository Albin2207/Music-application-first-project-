import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';

Future playlistBottomSheet(BuildContext context, Music song){
    return showModalBottomSheet(
      context: context, 
      backgroundColor: const Color.fromARGB(255, 65, 147, 188),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30)
        )
      ),
      builder: (context) => SizedBox(
        height: 500,
        child: ValueListenableBuilder(
          valueListenable: playlistNotifier,
          builder: (context, playlist, child) {
            return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: (){
                    PlaylistFunc.addSongToPlaylist(index, song, context);
                    Navigator.pop(context);
                  },
                  title: Text(playlist[index].name),
                );
              }
            );
          }
        ),
      ),
    );
  }