import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  final AudioPlayer player = AudioPlayer();

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();
}
