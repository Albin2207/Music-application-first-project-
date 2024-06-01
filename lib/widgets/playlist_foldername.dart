import 'package:flutter/material.dart';
import 'package:muscify_app/funtions/playlist_db.dart';


class PlaylistName {
  final _key = GlobalKey<FormState>();
  String folderName = "";
  TextEditingController folderNameController = TextEditingController();

  void saveFolderName() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      PlaylistFunc.createPlaylistFolder(folderName);
    }
  }

  Future<dynamic> playlistName(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 28, 107, 116),
          title: const Text(
            'Playlist Name',
            style: TextStyle(color: Colors.white)
          ),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: folderNameController,
              decoration: const InputDecoration(labelText: 'Enter playlist name'),
              onSaved: (value) {
                folderName = value.toString();
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                // save folder
                saveFolderName();
                Navigator.pop(context);
                folderNameController.clear();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}