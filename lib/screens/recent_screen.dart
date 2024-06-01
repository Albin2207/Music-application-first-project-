import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/recent_db.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:muscify_app/widgets/recent_list.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: 
              [
              Color.fromARGB(255, 0, 0, 0), 
              Color.fromARGB(255, 28, 107, 116), 
              Color(0xFF2C5364)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(color: itemscolor),
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors:
                       [
                        Colors.blue, 
                        Colors.green
                       ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "Recents",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.blueGrey, Color.fromARGB(255, 30, 94, 126)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    "Recently played",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: recentlyNotifier,
                    builder: (BuildContext context, List<Music> recentlySongs, Widget? child) {
                      if (recentlySongs.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Recently played songs!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: recentlySongs.length,
                        itemBuilder: (context, index) {
                          return RecentlyPlayedListview(
                            musicObj: recentlySongs[index],
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}