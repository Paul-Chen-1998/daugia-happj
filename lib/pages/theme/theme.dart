


import 'package:flutter/material.dart';
class GradientAppbar extends StatelessWidget {
  Color colorStart;
  Color colorEnd;

  GradientAppbar(this.colorStart, this.colorEnd);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[colorStart, colorEnd]),
      ),
    );
  }
}
