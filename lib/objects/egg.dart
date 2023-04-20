import 'package:flutter/material.dart';

class Egg extends StatelessWidget {
  final function;

  Egg({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.grey[800],
      ),
    );
  }
}
