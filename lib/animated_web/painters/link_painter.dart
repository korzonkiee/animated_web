import 'dart:ui';

import 'package:animated_web/animated_web/animated_web.dart';
import 'package:flutter/material.dart';

class LinkPainter {
  void paint({
    required Node centralNode,
    required List<Node> siblingNodes,
    required Canvas canvas,
    required Size canvasSize,
  }) {
    final scaledCentralNodeOffset = centralNode.currentOffset.scale(
      canvasSize.width,
      canvasSize.height,
    );

    for (var siblingNode in siblingNodes) {
      final scaledSinglingNodeOffset = siblingNode.currentOffset.scale(
        canvasSize.width,
        canvasSize.height,
      );

      const maximumDistance = 0.3;

      final distance = (centralNode.currentOffset - siblingNode.currentOffset)
          .distance
          .clamp(0, maximumDistance)
          .toDouble();

      final normalizedDistance = lerpDouble(
        0,
        1,
        distance / maximumDistance,
      )!;

      canvas.drawLine(
        scaledSinglingNodeOffset,
        scaledCentralNodeOffset,
        Paint()..color = Colors.white.withOpacity(1 - normalizedDistance),
      );
    }
  }
}
