import 'package:flutter/material.dart';
import 'package:pie_progress_indicator/pie_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: PieProgressIndicator(
            value: 0.15, // The progress value, ranging from 0.0 to 1.0.
            // color: Colors.grey.withOpacity(
            //     0.5), // The color of the progress segment with 50% opacity.
            // strokeColor: Colors.black, // The color of the surrounding circle. Defaults to the color parameter if not provided.
            // strokeWidth: 8.0, // The thickness of the surrounding circle. Defaults to 16% of the size if not provided.
            // backgroundColor: Colors.white, // The background color behind the progress indicator.
            // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // An optional animation for the progress color.
            // semanticsLabel: 'Loading progress', // A label for accessibility purposes.
            // semanticsValue: '15%', // A value description for accessibility purposes.
            // size: 100.0, // The size of the progress indicator. Defaults to 36.0 dp minimum if not provided.
            // valueStrokeFactor: 0.5, // The factor determining the thickness of the progress segment relative to the surrounding circle.
            // backgroundStrokeFactor: 0.5, // The factor determining the thickness of the background relative to the surrounding circle.
          ),
        ),
      ),
    );
  }
}
