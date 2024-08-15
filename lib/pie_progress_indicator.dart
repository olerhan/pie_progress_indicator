import 'dart:math';
import 'package:flutter/material.dart';

/// The [PieProgressPainter] class is a CustomPainter that draws a circular
/// progress indicator and a surrounding circle. The progress indicator is drawn
/// based on the provided [value].
class PieProgressPainter extends CustomPainter {
  /// The progress value, ranging from 0.0 to 1.0.
  final double value;

  /// The color of the progress segment.
  final Color color;

  /// The color of the surrounding circle.
  final Color strokeColor;

  /// The thickness of the surrounding circle.
  final double strokeWidth;

  /// The background color.
  final Color? backgroundColor;

  /// The factor determining the thickness of the progress segment relative to
  /// the surrounding circle's thickness.
  final double valueStrokeFactor;

  /// The factor determining the thickness of the background relative to the
  /// surrounding circle's thickness.
  final double backgroundStrokeFactor;

  /// Constructor for [PieProgressPainter], which takes all the required parameters
  /// to create a customizable progress indicator.
  PieProgressPainter({
    required this.value,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
    this.backgroundColor,
    required this.valueStrokeFactor,
    required this.backgroundStrokeFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint settings for drawing the background
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor ?? Colors.transparent
      ..style = PaintingStyle.fill;

    // Drawing the background
    final double factorBG = valueStrokeFactor.clamp(0.0, 1.0);
    final double radiusAdjustmentBG = strokeWidth * (2 * factorBG - 1);
    final double adjustedRadiusBG = (size.width + radiusAdjustmentBG) / 2;
    canvas.drawCircle(
        size.center(Offset.zero), adjustedRadiusBG, backgroundPaint);

    // Paint settings for drawing the surrounding circle
    final Paint borderPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Paint settings for drawing the progress in the surrounding circle
    final Paint borderProgressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Paint settings for drawing the progress segment
    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Start angle (0 degrees) and sweep angle (proportional to [value])
    const double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * value;
    final double noSweepAngle = 2 * pi * (1 - value);

    // Define the Rect for the progress segment (area to be covered by the circle)
    final rectBorder = Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.width / 2);

    // Define the Rect for the surrounding circle (area to be covered by the circle)
    final double factor = valueStrokeFactor.clamp(0.0, 1.0);
    final double radiusAdjustment = strokeWidth * (2 * factor - 1);
    final double adjustedRadius = (size.width + radiusAdjustment) / 2;
    final rectProgress = Rect.fromCircle(
        center: size.center(Offset.zero), radius: adjustedRadius);

    // Draw the surrounding circle
    canvas.drawArc(
        rectBorder, startAngle, sweepAngle, false, borderProgressPaint);
    canvas.drawArc(
        rectBorder, startAngle + sweepAngle, noSweepAngle, false, borderPaint);

    // Draw the progress segment
    canvas.drawArc(
      rectProgress,
      startAngle,
      sweepAngle,
      true,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(PieProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueStrokeFactor != valueStrokeFactor ||
        oldDelegate.backgroundStrokeFactor != backgroundStrokeFactor;
  }
}

/// The [PieProgressIndicator] class uses the [PieProgressPainter] to create
/// a circular progress indicator. This widget draws the progress according to
/// the [value] provided and allows customization of the surrounding circle's
/// color and thickness.
class PieProgressIndicator extends StatelessWidget {
  /// The progress value, ranging from 0.0 to 1.0.
  final double value;

  /// The color of the progress segment.
  final Color? color;

  /// The color of the surrounding circle.
  final Color? strokeColor;

  /// The thickness of the surrounding circle.
  final double? strokeWidth;

  /// The background color.
  final Color? backgroundColor;

  /// The animation for the progress color.
  final Animation<Color?>? valueColor;

  /// Adds a label for accessibility purposes.
  final String? semanticsLabel;

  /// Adds a value for accessibility purposes.
  final String? semanticsValue;

  /// The size of the indicator. If not provided, the size is determined automatically.
  final double? size;

  /// The factor determining the thickness of the progress segment relative to the surrounding circle.
  final double? valueStrokeFactor;

  /// The factor determining the thickness of the background relative to the surrounding circle.
  final double? backgroundStrokeFactor;

  /// Constructor for [PieProgressIndicator], which takes all the required parameters
  /// to create a customizable progress indicator.
  const PieProgressIndicator({
    super.key,
    required this.value,
    this.color,
    this.strokeColor,
    this.strokeWidth,
    this.backgroundColor,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.size,
    this.valueStrokeFactor,
    this.backgroundStrokeFactor,
  });

  Color _getEffectiveColor(BuildContext context) {
    return valueColor?.value ??
        color ??
        ProgressIndicatorTheme.of(context).color ??
        Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      value: semanticsValue,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // If the `size` parameter is not specified, it is set to a minimum of 36.0 dp
          final double effectiveSize = size ??
              constraints.smallest.shortestSide.clamp(36.0, double.infinity);
          // `strokeWidth` is set to 16% of the size
          final double effectiveStrokeWidth =
              strokeWidth ?? effectiveSize * 0.12;
          final Color effectiveColor = _getEffectiveColor(context);
          final Color effectiveStrokeColor = strokeColor ?? effectiveColor;
          final effectiveValueStrokeFactor = valueStrokeFactor ?? 0;
          final effectiveBackgroundStrokeFactor = backgroundStrokeFactor ?? 0;
          return SizedBox(
            width: effectiveSize,
            height: effectiveSize,
            child: CustomPaint(
              painter: PieProgressPainter(
                value: value,
                color: effectiveColor,
                strokeColor: effectiveStrokeColor,
                strokeWidth: effectiveStrokeWidth,
                backgroundColor: backgroundColor,
                valueStrokeFactor: effectiveValueStrokeFactor,
                backgroundStrokeFactor: effectiveBackgroundStrokeFactor,
              ),
            ),
          );
        },
      ),
    );
  }
}
