import 'package:flutter/material.dart';
import 'package:muscify_app/database/music_db.dart';
import 'package:muscify_app/widgets/allsongs_menu.dart';
import 'package:popover/popover.dart';


class PopUp extends StatelessWidget {
  final Music musicObj;
  const PopUp({
    super.key,
    required this.musicObj, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>showPopover(
        direction: PopoverDirection.left,
        context: context, bodyBuilder: (context)=> MenuItems(musicObj: musicObj),
        width: 200,
        height: 100
        ),
    
      child: const Icon(Icons.more_vert),
    );
  }
}