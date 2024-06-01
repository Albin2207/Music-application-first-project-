import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/screens/nowplaying_screen.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:muscify_app/widgets/leading_image.dart';
import 'package:muscify_app/widgets/songmenu_popup.dart';


ValueNotifier<List<Music>> songsNotifier = ValueNotifier([]);

class Songs extends StatefulWidget {
  final TextEditingController searchController;
  final List<Music> searchMusic;
  const Songs({
    Key? key,
    required this.searchController,
    required this.searchMusic,
  }) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSongList(),
    );
  }

  Widget _buildSongList() {
    return Container(
      color: bgcolor, 
      child: ValueListenableBuilder(
        valueListenable: songsNotifier,
        builder: (context, List<Music> songs, child) {
          // if no music
          if (songs.isEmpty) {
            return const Center(
              child: Text(
                "Music list is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: widget.searchController.text.isNotEmpty
                ? widget.searchMusic.length
                : songs.length,
            itemBuilder: (context, index) {
              final Music song = widget.searchController.text.isNotEmpty
                  ? widget.searchMusic[index]
                  : songs[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        musicObj: song,
                        currentIndex: index,
                      ),
                    ),
                  );
                },
                title: Text(
                  song.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white), 
                ),
                subtitle: Text(
                  song.artist ?? 'Empty',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey), 
                ),
               leading: LeadingImage(id: song.id),
                trailing: PopUp(
                  musicObj: song,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
