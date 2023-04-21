import 'package:flutter/material.dart';

class Egg extends StatelessWidget {
  final function;
  final child;

  Egg({this.child, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Color.fromARGB(255, 255, 227, 41),
        child: Center(child: eggSpace('images/egg.png')),
      ),
    );
  }

  Image eggSpace(pic) {
    return Image.asset(
      pic,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
  }
}
