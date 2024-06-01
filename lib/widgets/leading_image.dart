import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LeadingImage extends StatelessWidget {
  final int id;
  const LeadingImage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      nullArtworkWidget: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/images/rhythm.jpg'),
              fit: BoxFit.cover),
        ),
      ),
      id: id,
      type: ArtworkType.AUDIO,
    );
  }
}
