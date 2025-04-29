import 'dart:math';

import 'package:flutter/material.dart';

class ChooseMood extends StatefulWidget {
  @override
  State<ChooseMood> createState() => _ChooseMoodState();
}

class _ChooseMoodState extends State<ChooseMood>
    with SingleTickerProviderStateMixin {
  final List<String> emojis = ['😐', '🙂', '😄', '☹️', '😣'];
  final List<String> moods = ['Meh', 'Okay', 'Happy', 'Sad', 'Awful'];

  double rotation = 0;
  double itemAngle = pi / 6;
  int _currentIndex = 2;

  late final AnimationController _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    rotation = -(2 - (emojis.length - 1) / 2) * itemAngle;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _controller.addListener(() {
      if (_animation != null) {
        setState(() {
          rotation = _animation!.value;
          _currentIndex = selectedIndex;
        });
      }
    });
  }

  int get selectedIndex {
    int normalized = (-rotation / itemAngle).round();
    int index = ((emojis.length - 1) / 2 + normalized).round();
    return index.clamp(0, emojis.length - 1);
  }

  void _onDragEnd() {
    final int targetIndex = selectedIndex;
    final double targetRotation =
        -(targetIndex - (emojis.length - 1) / 2) * itemAngle;

    _animation = Tween<double>(begin: rotation, end: targetRotation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward(from: 0);
  }

  void _onDrag(DragUpdateDetails details) {
    setState(() {
      rotation += details.delta.dx * -0.01;
      _currentIndex = selectedIndex;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selIndex = _currentIndex;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'How are you feeling?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            moods[selIndex],
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onHorizontalDragUpdate: _onDrag,
          onHorizontalDragEnd: (_) => _onDragEnd(),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: CustomPaint(
              painter: MoodArcPainter(
                emojis: emojis,
                rotation: rotation,
                selectedIndex: selIndex,
                itemAngle: itemAngle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MoodArcPainter extends CustomPainter {
  final List<String> emojis;
  final double rotation;
  final int selectedIndex;
  final double itemAngle;

  MoodArcPainter({
    required this.emojis,
    required this.rotation,
    required this.selectedIndex,
    required this.itemAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height + 40);
    final radius = size.width / 2.2;

    for (int i = 0; i < emojis.length; i++) {
      final double angle = rotation + (i - (emojis.length - 1) / 2) * itemAngle;
      final Offset pos = Offset(
        center.dx + radius * cos(angle),
        center.dy - radius * sin(angle),
      );

      double distFromCenter = (angle - pi / 2).abs();
      distFromCenter = distFromCenter.clamp(0.0, pi / 2);
      double t = 1.0 - (distFromCenter / (pi / 2));
      double emojiSize = lerpDouble(26, 42, t)!;

      final tp = TextPainter(
        text: TextSpan(
          text: emojis[i],
          style: TextStyle(fontSize: emojiSize),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }
  }

  double? lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  bool shouldRepaint(covariant MoodArcPainter oldDelegate) => true;
}
