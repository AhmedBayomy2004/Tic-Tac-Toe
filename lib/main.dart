import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<String> arrayXO = ['', '', '', '', '', '', '', '', ''];
  bool xTurn = true;
  int score1 = 0;
  int score2 = 0;
  bool winnerExist = false;
  String winMsg = '';
  String buttonText = 'Start';
  bool started = false;
  Map<int, Color> colorMap = {
    for (int i = 0; i < 9; i++) i: Colors.yellow,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 106, 13),
        body: Column(
          children: [
            SizedBox(height: 55),
            Row(
              children: [
                Spacer(),
                Text(
                  "Player 1",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Coiny',
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                Text("Player 2",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Coiny',
                      fontSize: 25,
                    )),
                Spacer()
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Spacer(),
                Text(
                  score1.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Coiny',
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 30),
                Spacer(),
                Text(score2.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Coiny',
                      fontSize: 25,
                    )),
                Spacer()
              ],
            ),
            SizedBox(height: 35),
            Container(
              height: 500,
              padding: EdgeInsets.all(10),
              child: Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (!started) return;
                            changeXO(index);
                            checkWinner();
                            if (winnerExist && xTurn) {
                              winMsg = 'Player 2 Wins!';
                            } else if (winnerExist && !xTurn) {
                              winMsg = 'Player 1 Wins!';
                            } else if (checkDraw()) {
                              winMsg = 'Nobody Wins!';
                            }
                            if (winnerExist || checkDraw()) {
                              started = !started;
                              buttonText = 'Play again!';
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: colorMap[index],
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Text(
                                  arrayXO[index],
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 237, 106, 13),
                                      fontSize: 70,
                                      fontFamily: 'Coiny'),
                                ),
                                Spacer()
                              ],
                            ),
                          ));
                    }),
              ),
            ),
            Text(
              winMsg,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Coiny',
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: !started
                    ? () {
                        setState(() {
                          reset();
                        });
                      }
                    : null,
                child: Container(
                    width: 100,
                    child: Center(
                        child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ))))
          ],
        ),
      ),
    );
  }

  void changeXO(int index) {
    setState(() {
      if (arrayXO[index] == '' && xTurn) {
        arrayXO[index] = 'X';
        xTurn = !xTurn;
      } else if (arrayXO[index] == '' && !xTurn) {
        arrayXO[index] = 'O';
        xTurn = !xTurn;
      }
    });
  }

  void checkWinner() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      int a = condition[0];
      int b = condition[1];
      int c = condition[2];

      if (arrayXO[a] == arrayXO[b] &&
          arrayXO[b] == arrayXO[c] &&
          arrayXO[a] != '') {
        winnerExist = true;
        if (xTurn) {
          score2 += 1;
        } else {
          score1 += 1;
        }

        setState(() {
          colorMap[a] = Colors.blue;
          colorMap[b] = Colors.blue;
          colorMap[c] = Colors.blue;
        });
        return;
      }
    }
  }

  bool checkDraw() {
    if (arrayXO.contains('')) {
      return false;
    }
    return true;
  }

  void reset() {
    setState(() {
      arrayXO = ['', '', '', '', '', '', '', '', ''];
      xTurn = true;
      winnerExist = false;
      winMsg = '';
      started = !started;
      colorMap = {
        for (int i = 0; i < 9; i++) i: Colors.yellow,
      };
    });
  }
}
