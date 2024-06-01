import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muscify_app/screens/favorites_screen.dart';
import 'package:muscify_app/screens/playlist_screen.dart';
import 'package:muscify_app/screens/recent_screen.dart';
import 'package:muscify_app/widgets/all_colors.dart';

class SongSlider extends StatelessWidget {
  const SongSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Widget> sliderItems = [
      _buildSliderItem(
        "assets/images/rhythm.jpg",
        'Playlists',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlaylistScreen()),
          );
        },
      ),
      _buildSliderItem(
        "assets/images/rhythm.jpg",
        'Favorites',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
        },
      ),
      _buildSliderItem(
        "assets/images/rhythm.jpg",
        'Recents',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecentScreen()),
          );
        },
      ),
    ];

    return CarouselSlider(
      items: sliderItems,
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, value) {},
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildSliderItem(String imagePath, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              
            ),
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [labelcolor.withOpacity(1), Colors.transparent],
              ),
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        ],
      ),
    );
  }
}
