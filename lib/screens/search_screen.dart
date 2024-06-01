import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/widgets/all_colors.dart';

// Debouncer class
class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Music> searchMusic = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 800); 
  bool isLoading = false; // Loading state

  void updateSearchResults(String value) {
    setState(() {
      isLoading = true; // Start loading
    });

    _debouncer.run(() {
      searchMusic.clear();
      for (var song in songsNotifier.value) {
        if (song.title.toLowerCase().contains(value.toLowerCase())) {
          searchMusic.add(song);
        }
      }

      setState(() {
        isLoading = false; // Stop loading
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        toolbarHeight: 70,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: itemscolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            ).createShader(bounds);
          },
          child: const Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 28, 107, 116),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                searchTextField(),
                const SizedBox(height: 10),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white, // Change the color here
                              strokeWidth: 5.0, // Adjust the thickness as needed
                            ),
                          ),
                        )
                      : searchMusic.isEmpty && searchController.text.isNotEmpty
                          ? Center(
                              child: Image.asset(
                                'assets/images/error.webp',
                                width: 200,
                                height: 200,
                              ),
                            )
                          : Songs(
                              searchController: searchController,
                              searchMusic: searchMusic,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField searchTextField() {
    return TextField(
      onSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: searchController,
      onChanged: (value) {
        updateSearchResults(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(243, 255, 255, 255),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(Icons.search),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
            updateSearchResults(''); // Ensure the search results are updated when cleared
          },
        ),
        border: const OutlineInputBorder(),
        hintText: 'Find your song',
      ),
    );
  }
}
