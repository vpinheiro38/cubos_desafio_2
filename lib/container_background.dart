import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Widget child;

  ContainerBackground(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.black,
            ],
          )
      ),
      child: child,
    );
  }

}