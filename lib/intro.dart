import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';

// Generate random values for Malara
Random rand = new Random();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var spots = List.filled(45, 0);
  int currSpot = 22, step = rand.nextInt(45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Text(
            '${step}',
            style: TextStyle(fontSize: 40),
          ),
          Text(
            ' taps',
            style: TextStyle(fontSize: 15),
          ),
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(),
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
