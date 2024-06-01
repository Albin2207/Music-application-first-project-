import 'package:equalizer_flutter_custom/equalizer_flutter_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EqualizerProvider(),
      child: Scaffold(
        body: Center(
          child: CustomEqualizer(
            isEqEnabled: false,
            playerSessionId: 0, // function still not added
            bandTextColor: Colors.green,
            sliderBoxHeight: 220,
            sliderBoxPadding: 10,
            appbarElevation: 0,
            appBarShadowColor: Colors.grey,
            titleTextStyle: const TextStyle(color: Colors.red),
            sliderBoxBorderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
