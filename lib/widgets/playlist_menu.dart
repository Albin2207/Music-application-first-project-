import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/favorites_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/screens/playlist_box.dart';



class PlaylistMenuItems extends StatefulWidget {
  final int index;
  final int songIndex;
  final Music musicObj;

  const PlaylistMenuItems({
    super.key,
    required this.musicObj,
    required this.index,
    required this.songIndex,
  });

  @override
  State<PlaylistMenuItems> createState() => _PlaylistMenuItemsState();
}

class _PlaylistMenuItemsState extends State<PlaylistMenuItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1st menu option
        if (FavoriteFunctions.isFavor(widget.musicObj) == false)
          GestureDetector(
            onTap: () {
              FavoriteFunctions.addToFavorite(song: widget.musicObj);
              showSnackbar(context);
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              color: Colors.blueGrey[300],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add to favorite'),
                ],
              ),
            ),
          ),

        // 2nd menu
        if (FavoriteFunctions.isFavor(widget.musicObj) == true)
          GestureDetector(
            onTap: () {
              FavoriteFunctions.deleteFromFav(widget.musicObj.id);
              showRemoveSnackbar(context);
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              color: Colors.blueGrey[300],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Remove from favorite'),
                ],
              ),
            ),
          ),

        // remove from playlist
        GestureDetector(
          onTap: () {
            setState(() {
              PlaylistFunc.deleteSongFromPlaylist(
                  widget.index, widget.songIndex);
            });
            if (context.mounted) Navigator.pop(context);
            if (context.mounted) Navigator.pop(context);
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistEachFolder(
                          playlistObj: playlistNotifier.value[widget.index],
                          playlistindex: widget.index)));
            }
          },
          child: Container(
            height: 50,
            color: Colors.blueGrey[300],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remove from playlist'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added Successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showRemoveSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed Successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}
