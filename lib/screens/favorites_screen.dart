import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/favorites_db.dart';
import 'package:muscify_app/widgets/dialogue_empty.dart';
import 'package:muscify_app/widgets/favorite_list.dart';
import 'package:muscify_app/widgets/all_colors.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back, color: itemscolor),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
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
                              'Favourite Songs',
                              style: TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'My Favourite Songs',
                      style: TextStyle(
                        color: labelcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: favoriteNotifier,
              builder: (context, List<Music> favSongs, child) {
                if (favSongs.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: EmptyDialog(name: 'Favourite'),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FavoriteList(musicObj: favSongs[index], index: index);
                    },
                    childCount: favSongs.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: bgcolor,
    );
  }
}
