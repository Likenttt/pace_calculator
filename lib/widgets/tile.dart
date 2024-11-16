import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Widget child;
  const Tile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}
