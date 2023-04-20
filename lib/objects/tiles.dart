import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final child;
  final spot;
  final function;
  final check;

  Tiles({this.child, this.spot, this.check, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Color.fromARGB(255, 255, 227, 41),
        child: Center(
          child: this.child == spot
              ? check == true
                  ? boxSpace('images/malara-dead.png')
                  : boxSpace('images/mosquito-flying-box.gif')
              : Text(''),
        ),
      ),
    );
  }

  Image boxSpace(pic) {
    return Image.asset(
      pic,
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
  }
}


// 0  1  2  3  4
// 5  6  7  8  9
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24
// 25 26 27 28 29
// 30 31 32 33 34