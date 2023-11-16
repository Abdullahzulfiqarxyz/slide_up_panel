import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A customizable Flutter widget for creating a draggable and expandable panel
/// that slides up from the bottom of the screen.
class SlideUpPanel extends StatelessWidget {
  /// Key to uniquely identify this widget.

  /// Determines whether the draggable panel overlays the background widget.
  final bool overLay;

  /// Determines whether to apply rounded corners to the draggable panel.
  final bool rounded;

  /// The widget that appears in the background when the panel is not fully expanded.
  final Widget backGroundWidget;

  /// The widget that can be expanded or collapsed through dragging.
  final Widget sliderWidget;

  /// The minimum height of the draggable panel.
  final double minHeight;

  /// The maximum height to which the panel can be expanded.
  final double maxHeight;

  /// Constructor to initialize the [SlideUpPanel] widget.
  const SlideUpPanel({
    Key? key,
    required this.backGroundWidget,
    required this.sliderWidget,
    required this.minHeight,
    required this.maxHeight,
    this.rounded = false,
    this.overLay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reactive variable to track the height of the draggable panel.
    RxDouble containerHeight = minHeight.obs;

    // Logging the screen height for reference.

    // Calculating the size of the background widget.
    double backGroundWidgetSize =
        (MediaQuery.of(context).size.height) - minHeight;

    return Obx(
      () => Stack(
        children: [
          // Background elements, either overlaid or separated based on configuration.
          Column(
            children: [
              SizedBox(
                height: (overLay)
                    ? MediaQuery.of(context).size.height
                    : (rounded)
                        ? backGroundWidgetSize + 15
                        : backGroundWidgetSize,
                child: backGroundWidget,
              ),
              (overLay)
                  ? Container()
                  : SizedBox(
                      height: (rounded) ? minHeight - 15 : minHeight,
                      // Placeholder for additional background content.
                    ),
            ],
          ),
          // Positioned draggable panel controlled by user vertical drag gestures.
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) {
                // Adjust the container size based on the vertical drag.
                containerHeight.value -= details.primaryDelta!;
                // Constrain the size within specified minHeight and maxHeight.
                if (containerHeight < minHeight) {
                  containerHeight = minHeight.obs;
                } else if (containerHeight.value > maxHeight) {
                  containerHeight = maxHeight.obs;
                }
              },
              child: rounded
                  ? ClipRRect(
                      // Apply rounded corners if rounded is set to true.
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: containerHeight.value,
                        width: MediaQuery.of(context).size.width,
                        child: sliderWidget,
                      ),
                    )
                  : SizedBox(
                      height: containerHeight.value,
                      width: MediaQuery.of(context).size.width,
                      child: sliderWidget,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
