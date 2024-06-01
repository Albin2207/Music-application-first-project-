import 'package:flutter/material.dart';
import 'package:muscify_app/funtions/playlist_db.dart';



class PlaylistEditName {
  final _key = GlobalKey<FormState>();
  String folderName = "";
  TextEditingController folderNameController = TextEditingController();

  void saveEditFolder(int index) {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      PlaylistFunc.updateFolderName(index, folderName);
    }
  }

  Future<dynamic> folderNameAlertDialog(BuildContext context, int index, String playlistFolderName) {
    folderNameController.text = playlistFolderName;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:const Color.fromARGB(255, 28, 107, 116),
          title: const Text(
            'Edit playlist name',
            style: TextStyle(color: Colors. white),
          ),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: folderNameController,
              decoration: const InputDecoration(labelText: 'Folder Name'),
              onSaved: (value) {
                folderName = value.toString();
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
                saveEditFolder(index);
                Navigator.pop(context);
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
