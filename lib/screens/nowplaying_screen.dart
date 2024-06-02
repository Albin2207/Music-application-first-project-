import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:muscify_app/Songs/all_songs.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/funtions/favorites_db.dart';
import 'package:muscify_app/funtions/recent_db.dart';
import 'package:muscify_app/screens/equalizer_screen.dart';
import 'package:muscify_app/widgets/all_colors.dart';
import 'package:muscify_app/widgets/audio_backgroundplaying.dart';
import 'package:muscify_app/widgets/playlist_bottomsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';


class PlayScreen extends StatefulWidget {
  final Music musicObj;
  final int currentIndex;

  const PlayScreen({
    super.key,
    required this.musicObj,
    required this.currentIndex,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Duration? duration;
  late Music musicObjChange;
  late bool isFavorite;
  int currentSongIndex = 0;
  final AudioPlayer player = AudioPlayerService().player;
  bool _isShuffle = false;  
  bool _isRepeatOne = false;

  @override
  void initState() {
    super.initState();
    musicObjChange = widget.musicObj;
    onPlay(musicObjChange.path);
    currentSongIndex = widget.currentIndex;

    isFavorite = FavoriteFunctions.isFavor(musicObjChange);

    RecentlyFunctions.addToRecentlyPlayed(musicObjChange);
    currentSongIndex = widget.currentIndex;

    // Listen for player state changes
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        playNextSong();
      }
    });

    // Listen to playback events for just_audio_background
    player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }
 
  @override
  void dispose() {
    // Do not dispose the player to keep the music playing
    super.dispose();
  }

  Future<void> onPlay(String path) async {
    duration = await player.setAudioSource(
      AudioSource.uri(
        Uri.file(path),
        tag: MediaItem(
          id: '${musicObjChange.id}',
          album: musicObjChange.artist ?? 'Unknown Artist',
          title: musicObjChange.title,
          artUri: Uri.parse(''),
        ),
      ),
    );
    player.play();
    setState(() {
       isFavorite = FavoriteFunctions.isFavor(musicObjChange);//update isfavorite state to check next song is added or not
    });
  }

  void isFavoriteChanged(bool? value) {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite == false) {
        FavoriteFunctions.deleteFromFav(musicObjChange.id);
      } else {
        FavoriteFunctions.addToFavorite(song: musicObjChange);
      }
    });
  }
  void playPreviousSong() {
  setState(() {
    if (currentSongIndex > 0) {
      currentSongIndex--; // Move to the previous song index
    } else {
      currentSongIndex = songsNotifier.value.length - 1; // Loop to the last song if at the beginning
    }
    musicObjChange = songsNotifier.value[currentSongIndex];
    onPlay(musicObjChange.path); // Play the previous song
  });
}

  Future<void> playNextSong() async {
    if (_isShuffle) {
      // Play a random song if shuffle is active
      final random = Random();
      currentSongIndex = random.nextInt(songsNotifier.value.length);
    } else {
      // Play the next song in the list or repeat the current song if repeat mode is active
      if (_isRepeatOne) {
        // Do nothing, let the current song continue playing
      } else {
        if (currentSongIndex < songsNotifier.value.length - 1) {
          currentSongIndex++;
        } else {
          currentSongIndex = 0; // Loop back to the first song
        }
      }
    }
    musicObjChange = songsNotifier.value[currentSongIndex];
    await onPlay(musicObjChange.path);
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: gradientBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              children: [
                const SizedBox(height: 20),
                appBar(context),
                const SizedBox(height: 35),
                imageTitle(),
                const SizedBox(height: 35),
                durationProgress(),
                const SizedBox(height: 30),
                playbackControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageTitle() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: QueryArtworkWidget(
            artworkQuality: FilterQuality.high,
            artworkHeight: 220,
            artworkWidth: 250,
            nullArtworkWidget: Container(
              height: 220,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/rhythm.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            id: musicObjChange.id,
            type: ArtworkType.AUDIO,
          ),
        ),
        const SizedBox(height: 10),
        titleAndAlbum(),
      ],
    );
  }

  Widget titleAndAlbum() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  musicObjChange.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                icon: isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                onPressed: () => isFavoriteChanged(isFavorite),
                color: const Color.fromARGB(255, 223, 67, 56),
              ),
              const SizedBox(width: 5),
            ],
          ),
          Text(musicObjChange.artist ?? "no artist"),
        ],
      ),
    );
  }
Widget appBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: itemscolor,
        ),
      ),
      Column(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors:
                 [
                   Colors.blue, 
                   Colors.green
                ],
              ).createShader(bounds);
            },
            child: const Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
        IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EqualizerScreen(), // Use EqualizerScreen
            ),
          );
        },
        icon: const Icon(
          Icons.equalizer,
          color: itemscolor,
        ),
      ),
      ],
    );
  }

  Widget playbackControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                if (currentSongIndex > 0) {
                  currentSongIndex = currentSongIndex - 1;
                } else {
                  currentSongIndex = songsNotifier.value.length - 1;
                }
                musicObjChange = songsNotifier.value[currentSongIndex];
                onPlay(musicObjChange.path);
              },
              child: const Icon(Icons.skip_previous, size: 30, color: itemscolor),
            ),
            GestureDetector(
              onTap: () {
                if (player.playing) {
                  player.pause();
                } else {
                  player.play();
                }
                setState(() {});
              },
              child: Icon(
                player.playing ? Icons.pause : Icons.play_arrow,
                size: 60,
                color: itemscolor,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentSongIndex < songsNotifier.value.length - 1) {
                  currentSongIndex = currentSongIndex + 1;
                } else {
                  currentSongIndex = 0;
                }
                musicObjChange = songsNotifier.value[currentSongIndex];
                onPlay(musicObjChange.path);
              },
              child: const Icon(Icons.skip_next, size: 30, color: itemscolor),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.playlist_add),
              onPressed: () {
                playlistBottomSheet(context, widget.musicObj);
              },
              color: itemscolor,
            ),
            const SizedBox(height: 6),
         IconButton(
          icon: Stack(
           children: [
            Icon(Icons.shuffle, color: _isShuffle ? Colors.green : itemscolor),
             Positioned.fill(
             child: Align(
              alignment: Alignment.center,
               child: _isShuffle
               ? const Icon(Icons.pause_circle_filled, color: Colors.green, size: 12)
                : Container(),
              ),
             ),
            ],
           ),
          onPressed: () {
           setState(() {
           _isShuffle = !_isShuffle;
         });
           if (_isShuffle) {
            final random = Random();
             currentSongIndex = random.nextInt(songsNotifier.value.length);
             musicObjChange = songsNotifier.value[currentSongIndex];
             onPlay(musicObjChange.path);
            }
           final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text(_isShuffle ? 'Shuffle Mode On' : 'Shuffle Mode Off'),
             duration: const Duration(seconds: 1),
           );
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
           color: itemscolor,
         ),

           const SizedBox(height: 6),
      IconButton(
        icon: Icon(
        _isRepeatOne ? Icons.repeat_one : Icons.repeat,
          color: _isRepeatOne ? Colors.green : itemscolor,
        ),
         onPressed: () {
          setState(() {
          _isRepeatOne = !_isRepeatOne;
       });
       final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text(_isRepeatOne ? 'Repeat Mode On' : 'Repeat Mode Off'),
         duration: const Duration(seconds: 1),
       );
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
       ),
      ],
     ),
    ],
   );
  }

  Widget durationProgress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                stream: player.positionStream,
                builder: (context, duration) {
                  return Text(
                    durationFormat(duration.data ?? Duration.zero),
                    style: const TextStyle(color: itemscolor),
                  );
                },
              ),
              Text(
                durationFormat(duration ?? Duration.zero),
                style: const TextStyle(color: itemscolor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: player.positionStream,
          builder: (context, durations) {
            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
              ),
              child: Slider(
                min: 0,
                max: duration?.inSeconds.toDouble() ?? 1.0,
                value: player.position.inSeconds.toDouble(),
                activeColor: itemscolor,
                onChanged: (value) {
                  player.seek(Duration(seconds: value.round()));
                },
              ),
            );
          },
        ),
      ],
    );
  }

  BoxDecoration gradientBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 28, 107, 116),
          Color(0xFF2C5364),
        ],
      ),
    );
  }

  String durationFormat(Duration d) {
    if (d.inHours > 0) {
      return d.toString().split('.').first.padLeft(8, "0");
    }
    return d.toString().substring(2, 7);
  }
}