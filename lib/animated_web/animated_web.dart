import 'package:animated_web/animated_web/animated_web_painter.dart';
import 'package:flutter/material.dart';

export 'models/models.dart';
export 'painters/painters.dart';

class AnimatedWeb extends StatefulWidget {
  const AnimatedWeb({Key? key}) : super(key: key);

  @override
  State<AnimatedWeb> createState() => _AnimatedWebState();
}

class _AnimatedWebState extends State<AnimatedWeb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: CustomPaint(
        child: Container(),
        painter: AnimatedWebPainter(
          animation: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
