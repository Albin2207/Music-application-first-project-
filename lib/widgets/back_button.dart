import 'package:flutter/material.dart';
import 'package:muscify_app/widgets/all_colors.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: itemscolor, 
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 15,
          color: labelcolor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
