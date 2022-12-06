import 'package:flutter/material.dart';

class DarkImage extends StatelessWidget {
  final Widget child;
  final int alpha;
  const DarkImage({required this.child, required this.alpha});
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withAlpha(alpha), BlendMode.darken),
      child: child,
    );
  }
}
