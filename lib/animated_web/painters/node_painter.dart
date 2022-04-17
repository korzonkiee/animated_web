import 'package:animated_web/animated_web/animated_web.dart';
import 'package:flutter/material.dart';

class NodePainter {
  void paint({
    required Node node,
    required Canvas canvas,
    required Size canvasSize,
    double nodeRadius = 2,
  }) {
    /// The node's offset is represented as values from 0 to 1.
    ///
    /// In order to paint it on the canvas, we need to scale so that it
    /// is compatible with the canvas's size.
    final scaledOffset = node.currentOffset.scale(
      canvasSize.width,
      canvasSize.height,
    );

    canvas.drawCircle(
      scaledOffset,
      nodeRadius,
      Paint()..color = Colors.white,
    );
  }
}
