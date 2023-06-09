import 'package:flutter/material.dart';

import 'objects/egg.dart';
import 'objects/tiles.dart';

// Realtime
DateTime now = DateTime.now();

List<int> eggsOn = []; // egg locations (can be used right away)

// initial possible moves
List possibleMoves = [
  currSpot - 1,
  currSpot + 1,
  currSpot - x - 1,
  currSpot - x,
  currSpot - x + 1,
  currSpot + x - 1,
  currSpot + x,
  currSpot + x + 1,
];

int x = 7, y = 7; // easy = 5x7  medium = 8x11 hard = 10x14
int numSquares = x * y; // x * y
int currSpot = (numSquares / 2).floor();
int taps = 0, eggCount = 0;
bool caught = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int step = (possibleMoves..shuffle()).first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void restartGame() {
    setState(
      () {
        caught = false;
        taps = 0;
        eggCount = 0;
        currSpot = (numSquares / 2).floor();
        eggsOn.clear();
        possibleMoves = [
          currSpot - 1,
          currSpot + 1,
          currSpot - x - 1,
          currSpot - x,
          currSpot - x + 1,
          currSpot + x - 1,
          currSpot + x,
          currSpot + x + 1,
        ];
      },
    );
  }

  void setMalaraSpot(int index) {
    setState(() {
      step = (possibleMoves..shuffle()).first;
      if (step != currSpot) {
        eggsOn.add(currSpot);
      } else if (possibleMoves.length <= 1) {
        step = currSpot;
      }
      if (eggsOn.contains(step) && step != currSpot)
        while (eggsOn.contains(step)) {
          if (possibleMoves.length <= 1) {
            print('trapped');
            break;
          }
          possibleMoves.remove(step);

          step = (possibleMoves..shuffle()).first;
        }

      // set counts of egg planted
      eggCount = eggsOn.length;

      if (eggsOn.length == 15) {
        print('Malara won');
        malaraWon();
      } else if (step == index) {
        print('caught');
        caught = true;
        malaraCaught();
      } else {
        print('missed');
        currSpot = step;
        possibleMoves.clear();
      }
    });
  }

  void setMove(currSpot) {
    setState(() {
      // initial move, no eggs
      possibleMoves.add(currSpot);

      //  top left
      if (currSpot == 0) {
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot + x);
        possibleMoves.add(currSpot + x + 1);
      }
      //  top right
      else if (currSpot == x - 1) {
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot + x - 1);
        possibleMoves.add(currSpot + x);
      }
      // bottom left
      else if (currSpot == numSquares - x) {
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot - x);
        possibleMoves.add(currSpot - x + 1);
      }
      // bottom right
      else if (currSpot == numSquares - 1) {
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot - x - 1);
        possibleMoves.add(currSpot - x);
      }
      //  left, not first or last row
      else if (currSpot >= x &&
          currSpot <= numSquares - x &&
          currSpot % x == 0) {
        possibleMoves.add(currSpot - x);
        possibleMoves.add(currSpot - x + 1);
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot + x);
        possibleMoves.add(currSpot + x + 1);
      }
      //  right, not first or last row
      else if (currSpot >= x &&
          currSpot <= numSquares - x &&
          currSpot % x == x - 1) {
        possibleMoves.add(currSpot - x);
        possibleMoves.add(currSpot - x - 1);
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot + x);
        possibleMoves.add(currSpot + x - 1);
      }
      //  top, not first or last column
      else if (currSpot < x) {
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot + x - 1);
        possibleMoves.add(currSpot + x);
        possibleMoves.add(currSpot + x + 1);
      }
      //  bottom, not first or last column
      else if (currSpot > numSquares - x) {
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot - x - 1);
        possibleMoves.add(currSpot - x);
        possibleMoves.add(currSpot - x + 1);
      } else {
        possibleMoves.add(currSpot - 1);
        possibleMoves.add(currSpot + 1);
        possibleMoves.add(currSpot - x - 1);
        possibleMoves.add(currSpot - x);
        possibleMoves.add(currSpot - x + 1);
        possibleMoves.add(currSpot + x - 1);
        possibleMoves.add(currSpot + x);
        possibleMoves.add(currSpot + x + 1);
      }
    });
  }

  void malaraCaught() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.grey[700],
              title: Center(
                child: Text(
                  'You caught Malara in $taps taps only! Good Job!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actions: [
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.refresh),
                )
              ]);
        });
  }

  void malaraWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.grey[700],
              title: Center(
                child: Text(
                  'Malara won! She succesfully planted her eggs and spread out her colony. \n\nHow come you reached $taps without catching her? Noob.\n\nWell, Better luck next time.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actions: [
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    restartGame();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.refresh),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 226, 157),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$taps', style: TextStyle(fontSize: 40)),
                    Text('T A P'),
                  ],
                ),

                // button to refresh the game
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    child: Icon(Icons.refresh, color: Colors.white, size: 40),
                    color: Color.fromARGB(255, 14, 0, 212),
                  ),
                ),

                // display number of malara eggs
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$eggCount', style: TextStyle(fontSize: 40)),
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
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: x),
              itemBuilder: (context, index) {
                if (eggsOn.contains(index)) {
                  return Egg(
                    child: index,
                    function: () {
                      // malara plants her eggs
                      // MOVE EVERYTHING HERE INSIDE Tiles
                      setMove(currSpot);
                    },
                  );
                } else {
                  return Tiles(
                    child: index,
                    spot: currSpot,
                    check: caught,
                    function: () {
                      // tap tile
                      setMalaraSpot(index);
                      setMove(currSpot);
                      taps++;
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
