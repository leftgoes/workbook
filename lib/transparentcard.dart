import 'package:flutter/material.dart';

class TransparentCard extends StatelessWidget {
  const TransparentCard({
    super.key,
    required this.child,
    this.elevation = 100.0,
  });

  final Widget child;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).shadowColor),
          borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
