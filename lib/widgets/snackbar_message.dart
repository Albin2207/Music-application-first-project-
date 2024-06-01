import 'package:flutter/material.dart';

void showSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added Successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }