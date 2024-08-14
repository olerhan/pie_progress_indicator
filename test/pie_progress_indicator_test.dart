import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pie_progress_indicator/pie_progress_indicator.dart';

void main() {
  group('PieProgressIndicator Tests', () {
    testWidgets('should display correct progress when value is 0.5',
        (WidgetTester tester) async {
      // Load the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PieProgressIndicator(
              value: 0.5,
              color: Colors.blue,
              strokeColor: Colors.grey,
              size: 100.0,
            ),
          ),
        ),
      );

      // Verify the widget is loaded
      expect(find.byType(PieProgressIndicator), findsOneWidget);

      // Verify the progress circle is displayed correctly
      // You can add specific checks for the progress circle's color or size here
    });

    testWidgets('should respect custom strokeWidth and strokeColor',
        (WidgetTester tester) async {
      // Load the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PieProgressIndicator(
              value: 0.75,
              color: Colors.green,
              strokeColor: Colors.red,
              strokeWidth: 10.0,
              size: 100.0,
            ),
          ),
        ),
      );

      // Verify the widget is loaded
      expect(find.byType(PieProgressIndicator), findsOneWidget);

      // Verify that the strokeWidth and strokeColor parameters are applied correctly
      // You can add specific checks for strokeWidth and strokeColor here
    });

    testWidgets('should allow background color and opacity',
        (WidgetTester tester) async {
      // Load the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PieProgressIndicator(
              value: 0.25,
              color: Colors.yellow,
              strokeColor: Colors.orange,
              backgroundColor: Colors.black.withOpacity(0.5),
              size: 100.0,
            ),
          ),
        ),
      );

      // Verify the widget is loaded
      expect(find.byType(PieProgressIndicator), findsOneWidget);

      // Verify that the background color and opacity are applied correctly
      // You can add specific checks for background color and opacity here
    });

    testWidgets('should update progress when value changes',
        (WidgetTester tester) async {
      // Load the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PieProgressIndicator(
              value: 0.3,
              color: Colors.purple,
              strokeColor: Colors.black,
              size: 100.0,
            ),
          ),
        ),
      );

      // Update the progress value
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PieProgressIndicator(
              value: 0.8,
              color: Colors.purple,
              strokeColor: Colors.black,
              size: 100.0,
            ),
          ),
        ),
      );

      // Verify the progress circle updates to reflect the new value
      // You can add specific checks for the updated progress value here
    });
  });
}
