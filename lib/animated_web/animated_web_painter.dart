import 'dart:math';
import 'dart:ui';

import 'package:animated_web/animated_web/animated_web.dart';
import 'package:flutter/material.dart';

class AnimatedWebPainter extends CustomPainter {
  AnimatedWebPainter({
    required Animation<double> animation,
    int numberOfNodes = 16,
    Random? random,
    NodePainter? nodePainter,
    LinkPainter? linkPainter,
  })  : _animation = animation,
        _random = random ?? Random(),
        _nodePainter = nodePainter ?? NodePainter(),
        _linkPainter = linkPainter ?? LinkPainter(),
        super(repaint: animation) {
    _nodes = _generateNodes(numberOfNodes);
  }

  final Animation<double> _animation;
  final Random _random;
  final NodePainter _nodePainter;
  final LinkPainter _linkPainter;

  late final List<Node> _nodes;

  @override
  void paint(Canvas canvas, Size size) {
    for (final node in _nodes) {
      _nodePainter.paint(
        node: node,
        canvas: canvas,
        canvasSize: size,
      );

      _linkPainter.paint(
        centralNode: node,
        siblingNodes: _nodes,
        canvas: canvas,
        canvasSize: size,
      );

      node.move();
    }
  }

  List<Node> _generateNodes(int numberOfNodes) {
    return List.generate(numberOfNodes, (index) {
      final randomInitialOffset = _generateRandomOffset();
      final randomInitialDirection = _generateRandomDirection();
      final randomMoveDistance = _generateRandomMoveDistance();

      return Node(
        initialOffset: randomInitialOffset,
        initialDirection: randomInitialDirection,
        moveDistance: randomMoveDistance,
      );
    });
  }

  Offset _generateRandomOffset() {
    final randomX = _random.nextDouble();
    final randomY = _random.nextDouble();

    return Offset(
      randomX,
      randomY,
    );
  }

  double _generateRandomDirection() {
    return _random.nextDouble() * 2 * pi;
  }

  double _generateRandomMoveDistance() {
    return lerpDouble(0.002, 0.004, _random.nextDouble())!;
  }

  @override
  bool shouldRepaint(covariant AnimatedWebPainter oldDelegate) {
    return oldDelegate._animation.value != _animation.value;
  }
}
