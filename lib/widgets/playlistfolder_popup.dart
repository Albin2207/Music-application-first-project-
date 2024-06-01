import 'package:flutter/material.dart';
import 'package:muscify_app/funtions/playlist_db.dart';
import 'package:muscify_app/widgets/playlist_editname.dart';
import 'package:popover/popover.dart';


class PlaylistFolderPopUp extends StatelessWidget {
  final String folderName;
  final int index;
  const PlaylistFolderPopUp({super.key, required this.index, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        direction: PopoverDirection.bottom,
        context: context, 
        bodyBuilder: (context) {
         return Column(
          children: [
            removeFolder(context),
            editFolderName(context)
          ],
         );
        },
        width: 250,  
        height: 100,  
      ),
      child: const Icon(Icons.more_vert),
    );
  }

  GestureDetector removeFolder(BuildContext context) {
    return GestureDetector(
        onTap: () {
          PlaylistFunc.deletePlaylist(index);
          showRemoveSnackbar(context);
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          color: Colors.blueGrey[300],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Remove Folder'),
            ],
          ),
        ),
      );
  }

    GestureDetector editFolderName(BuildContext context) {
    return GestureDetector(
        onTap: () {
          PlaylistEditName editName = PlaylistEditName();
          editName.folderNameAlertDialog(context, index, folderName);
        },
        child: Container(
          height: 50,
          color: Colors.blueGrey[300],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Edit Folder Name'),
            ],
          ),
        ),
      );
  }

  void showRemoveSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed Successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}