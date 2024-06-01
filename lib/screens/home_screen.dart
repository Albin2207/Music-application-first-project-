import 'package:flutter/material.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/screens/privacy_policy.dart';
import 'package:muscify_app/screens/search_screen.dart';
import 'package:muscify_app/screens/termsand_conditions.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:muscify_app/widgets/bottom_navigationbar.dart';
import 'package:muscify_app/widgets/display_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: 
              [
                
               Colors.blue, 
               Colors.green
              ],
            ).createShader(bounds);
          },
          child: const Text(
            'MUSIFIC',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: bgcolor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: itemscolor,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Search()),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: itemscolor),
        toolbarHeight: 70,
      ),
      bottomNavigationBar: const CustomNavBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 107, 116),
              ),
              child: Icon(Icons.audiotrack,
              color: Color.fromARGB(255, 227, 182, 19),
              size: 80,
             )
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
              },
            ),
            ListTile(
              title: const Text('Terms & Conditions'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsAndConditions()));
              },
            ),
            ListTile(
             title: const Text("About Us"),
              onTap: () {
              showDialog(
               context: context,
               builder: (context) {
                return const AlertDialog(
                 backgroundColor: Color.fromARGB(255, 28, 107, 116),
                 title: Text('About Musific',style: TextStyle(color:Colors.white),),
            content: Text(
            'Musific is a Music platform where you can listen to your favorite music from your phone with easy access and segregating them by categories and more features on the way!',
          style: TextStyle(color: Colors.white),),
         );
        },
       );
      },
     ),
    ]
   )
  ),
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SongSlider(),
              const SizedBox(height: 10),
              const Text(
                'All Songs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color adjusted to contrast with the gradient background
                ),
              ),
              const SizedBox(height:15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const  Color.fromARGB(255, 28, 107, 116),
                    borderRadius: BorderRadius.circular(15), 
                   
                  
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Songs(
                      searchController: TextEditingController(),
                      searchMusic: [],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}