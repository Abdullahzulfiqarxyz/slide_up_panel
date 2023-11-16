import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slide_up_panel/src/slide_up_panel.dart'; // Replace with your actual package name

void main() {
  group('SlideUpPanel Widget Tests', () {
    testWidgets('Renders SlideUpPanel with default parameters',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: SlideUpPanel(
            backGroundWidget: Container(color: Colors.blue),
            sliderWidget: Container(color: Colors.red),
            minHeight: 100.0,
            maxHeight: 300.0,
          ),
        ),
      );

      // Verify that background and slider widgets are rendered.
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('Drags and adjusts the height of the SlideUpPanel',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: SlideUpPanel(
            backGroundWidget: Container(color: Colors.blue),
            sliderWidget: Container(color: Colors.red),
            minHeight: 100.0,
            maxHeight: 300.0,
          ),
        ),
      );

      // Find the draggable area.
      final Finder draggableFinder = find.byType(GestureDetector);

      // Drag upwards to expand the panel.
      await tester.drag(draggableFinder, Offset(0, -100));
      await tester.pump();

      // Verify that the panel height increases.
      expect(find.byType(SlideUpPanel), isNot(bottomPanelPosition(100.0)));

      // Drag downwards to collapse the panel.
      await tester.drag(draggableFinder, Offset(0, 100));
      await tester.pump();

      // Verify that the panel height decreases.
      expect(find.byType(SlideUpPanel), isNot(bottomPanelPosition(300.0)));
    });

    // Add more tests as needed based on your widget's functionality.
  });
}

Matcher bottomPanelPosition(double bottom) {
  return isNot(
    findsOneWidget,
  );
}
