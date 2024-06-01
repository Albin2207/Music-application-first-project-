import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:muscify_app/database/playlist_db.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/screens/playlist_box.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:muscify_app/widgets/dialogue_empty.dart';
import 'package:muscify_app/widgets/playlist_foldername.dart';
import 'package:muscify_app/widgets/playlistfolder_popup.dart';



class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    super.key,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistState();
}

class _PlaylistState extends State<PlaylistScreen> {
  late Box playlistBox;

  @override
  void initState() {
    super.initState();
    playlistBox = Hive.box<Playlist>('playlistBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: itemscolor),
        onPressed: () {
          Navigator.pop(context);
        },),
        backgroundColor: Colors.black,
        toolbarHeight: 86,
        title: ShaderMask(
  shaderCallback: (Rect bounds) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: 
      [
        Colors.blue, 
        Colors.green
      ],
    ).createShader(bounds);
  },
  child: const Text(
    'My Playlist',
    style: TextStyle(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: 
                  [
                   Color.fromARGB(255, 0, 0, 0), 
                   Color.fromARGB(255, 28, 107, 116), 
                   Color(0xFF2C5364)
                  ]
                  )
                  ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // folders
                ValueListenableBuilder(
                    valueListenable: playlistNotifier,
                    builder: (context, playlist, child) {
                      if(playlist.isEmpty){
                        return const Padding(
                    padding:  EdgeInsets.only(top: 130),
                    child: EmptyDialog(name: 'Playlist'),
                  );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: playlist.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylistEachFolder(
                                    playlistObj: playlist[index],
                                    playlistindex: index,
                                  ),
                                ),
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: 
                                      [
                                         Color.fromARGB(255, 29, 60, 86), 
                                         Color.fromARGB(255, 17, 93, 20) 
                                      ]
                                      ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(playlist[index].name,
                                            style: const TextStyle(color: itemscolor),
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      PlaylistFolderPopUp(
                                        index: index, folderName: playlist[index].name,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          PlaylistName createFolderName = PlaylistName();
          createFolderName.playlistName(context);
        },
        child: const Icon(
          Icons.add,
          color: labelcolor,
        ),
      ),
    );
  }
}
