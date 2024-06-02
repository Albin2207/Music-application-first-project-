import "package:flutter/material.dart";
import "package:muscify_app/screens/favorites_screen.dart";
import "package:muscify_app/screens/home_screen.dart";
import "package:muscify_app/screens/playlist_screen.dart";
import "package:muscify_app/widgets/all_colors.dart";


class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.white,
      selectedItemColor: itemscolor,
      backgroundColor: bgcolor,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: itemscolor,
        ), 
        label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.playlist_add,color: itemscolor,
        ), 
        label: 'Playlists'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,color: itemscolor,),
          label: 'Favorite',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const PlaylistScreen()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()));
            break;
          
        }
      },
    );
  }
}