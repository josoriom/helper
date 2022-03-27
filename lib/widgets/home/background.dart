import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.8],
          colors: [Color.fromRGBO(5, 76, 102, 1), Color(0xff202333)]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Purple gradient
          Container(
            decoration: boxDecoration,
          ),

          // Pink box
          const Positioned(top: -100, left: -30, child: _PinkBox()),
        ],
      ),
    );
  }
}

class _PinkBox extends StatelessWidget {
  const _PinkBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 12.0,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(80),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(21, 109, 142, 1),
              Color.fromRGBO(5, 76, 102, 1)
            ])),
      ),
    );
  }
}
