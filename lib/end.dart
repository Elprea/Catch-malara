import 'package:flutter/material.dart';
import 'dart:math';

import 'objects/egg.dart';
import 'objects/tiles.dart';

// Generate random values for Malara
Random rand = new Random();
int tileCount = 5;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variables
  int numSquares = 5 * 7;
  int numRow = 5;

  // [number of malara eggs, revealed = true / false]
  var squareStatus = [];

  List<int> eggsOn = [
    11,
    13,
    17,
    21,
    23,
  ];
  bool eggRevealed = false;

  @override
  void initState() {
    super.initState();

    // initially, 0 eggs and not revealed
    for (int i = 0; i < numSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanEggs();
  }

  int currSpot = 0, step = rand.nextInt(tileCount);
  var spots = List.filled(tileCount, 0);

  void revealTiles(int index) {
    setState(() {
      squareStatus[index][1] = true;
    });
  }

  void scanEggs() {
    for (int i = 0; i < numSquares; i++) {
      // initially, no eggs
      int numEggs = 0;

      //  left, unless it is in first column
      if (eggsOn.contains(i - 1) && i % numRow != 0) {
        numEggs++;
      }

      //  top left, unless it is in first column or first row
      if (eggsOn.contains(i - 1 - numRow) && i % numRow != 0 && i >= numRow) {
        numEggs++;
      }

      //  top, unless it is in first column
      if (eggsOn.contains(i - numRow) && i >= numRow) {
        numEggs++;
      }

      //  top right, unless it is in first column or first row
      if (eggsOn.contains(i + 1 - numRow) &&
          i % numRow != numRow - 1 &&
          i >= numRow) {
        numEggs++;
      }

      //  right, unless it is in first column
      if (eggsOn.contains(i + 1) && i % numRow != numRow - 1) {
        numEggs++;
      }

      //  bottom right, unless it is in first column or first row
      if (eggsOn.contains(i + 1 + numRow) &&
          i % numRow != numRow - 1 &&
          i < numSquares - numRow) {
        numEggs++;
      }

      //  bottom, unless it is in first column
      if (eggsOn.contains(i + 1) && i < numSquares - numRow) {
        numEggs++;
      }

      //  bottom left, unless it is in first column or first row
      if (eggsOn.contains(i - 1 + numRow) &&
          i % numRow != 0 &&
          i < numSquares - numRow) {
        numEggs++;
      }

      setState(() {
        squareStatus[i][0] = numEggs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            // game stats
            Container(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // display number of taps
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('0', style: TextStyle(fontSize: 40)),
                      Text('T A P'),
                    ],
                  ),

                  // button to refresh the game
                  Card(
                    child: Icon(Icons.refresh, color: Colors.white, size: 40),
                    color: Colors.grey[700],
                  ),

                  // display number of malara eggs
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('0', style: TextStyle(fontSize: 40)),
                      Text('E G G'),
                    ],
                  )
                ],
              ),
            ),

            // tiles
            Expanded(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: numSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numRow),
                itemBuilder: (context, index) {
                  if (eggsOn.contains(index)) {
                    return Egg(
                      //revealed: eggRevealed,
                      function: () {
                        // malara plants her eggs
                        setState(() {
                          eggRevealed = true;
                        });
                      },
                    );
                  } else {
                    return Tiles(
                      child: index,
                      //revealed: squareStatus[index][1],
                      function: () {
                        // reveal current tile
                        revealTiles(index);
                      },
                    );
                  }
                },
              ),
            ),
            // branding
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text('C A T C H   M A L A R A   G A M E'),
            )
          ],
        )

        // body: GridView.count(crossAxisCount: 5, children: [
        //   for (var x = 0; x < tileCount; x++)
        //     InkWell(
        //       onTap: () {
        //         setState(() {
        //           step = rand.nextInt(tileCount);
        //           currSpot = step;
        //           print(currSpot);
        //           if (x == currSpot) {
        //             boxSpace('images/malara-dead.png');
        //             print('You found malara in $x');
        //           } else
        //             print('Malara is not here');
        //         });
        //       },
        //       child: x == currSpot
        //           ? boxSpace('images/mosquito-flying-box.gif')
        //           : boxSpace('images/yellow-bg.png'),
        //       // child: spots[x] ==
        //       //     ? boxSpace('images/yellow-bg.png'
        //       //     : spots[x] ==
        //       //         ? boxSpace('images/mosquito-flyig.gif')
        //       //         : boxSpace('images/yellow-bg.png),
        //       // child: Text(spots[x] == 0 ? '' : spots[x == 1 ? 'X' : 'O'),
        //     )
        // ]),
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
