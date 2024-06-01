import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/screens/nowplaying_screen.dart';
import 'package:muscify_app/widgets/songmenu_popup.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedListview extends StatelessWidget {
  final Music musicObj;
  final int index;

  const RecentlyPlayedListview({super.key, required this.musicObj, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => PlayScreen(musicObj: musicObj, currentIndex: index,)
        ),
      ),
      leading: QueryArtworkWidget(
                    nullArtworkWidget: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/rhythm.jpg'),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    id: musicObj.id,
                    type: ArtworkType.AUDIO,
              ),
      title: Text(musicObj.title ,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
      subtitle: Text(musicObj.artist??"No Artist",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
      trailing: PopUp(musicObj: musicObj,)
    );
  }
}