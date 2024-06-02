import 'package:flutter/material.dart';
import 'package:equalizer_flutter_custom/equalizer_flutter_custom.dart';



class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equalizer'),
      ),
      body: CustomEqualizer(
        isEqEnabled: true,
        playerSessionId:0, 
        bandTextColor: Colors.green,
        sliderBoxHeight: 220,
        sliderBoxPadding: 10,
        appbarElevation: 0,
        appBarShadowColor: Colors.grey,
        titleTextStyle: const TextStyle(color: Colors.red),
        sliderBoxBorderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
