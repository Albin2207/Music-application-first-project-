import 'package:flutter/material.dart';
import 'package:muscify_app/screens/home_screen.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  Future<void> gotoHome() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0,
          color: const Color.fromARGB(0, 122, 10, 10),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 164, 118, 10)
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(top: 120),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.audiotrack,
                  color: Color.fromARGB(255, 227, 182, 19),
                  size: 150.0,
                ),
              SizedBox(height: 20),
               Text(
                  'MUSIFIC',
                  style: TextStyle(
                    color: Color.fromARGB(255, 227, 182, 19),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
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
