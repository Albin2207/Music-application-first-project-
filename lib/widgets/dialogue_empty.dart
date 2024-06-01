import 'package:flutter/material.dart';
import 'package:muscify_app/widgets/all_colors.dart';

class EmptyDialog extends StatelessWidget {
  final String name;
  const EmptyDialog({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("$name list is Empty",
        style: const TextStyle(fontWeight: FontWeight.bold, color: itemscolor),
      ),
    );
  }
}
