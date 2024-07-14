import 'package:flutter/material.dart';
import 'package:tictac/constants.dart';
import 'package:tictac/data/logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    ...firstbloc(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8),
                        child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 1,
                            children: List.generate(
                                9,
                                (index) => GestureDetector(
                                      onTap:
                                          gameOver ? null : () => _onTap(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: styles.KShadowColor),
                                        child: Center(
                                          child: Text(
                                            Player.playerX.contains(index)
                                                ? 'X'
                                                : Player.playerO.contains(index)
                                                    ? 'O'
                                                    : '',
                                            style: TextStyle(
                                                color: Player.playerX
                                                        .contains(index)
                                                    ? styles.KPrimarySwatch
                                                    : Colors.pink,
                                                fontSize: 40),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                    ),
                    ...secondBloc()
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8),
                        child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 1,
                            children: List.generate(
                                9,
                                (index) => GestureDetector(
                                      onTap:
                                          gameOver ? null : () => _onTap(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: styles.KShadowColor),
                                        child: Center(
                                          child: Text(
                                            Player.playerX.contains(index)
                                                ? 'X'
                                                : Player.playerO.contains(index)
                                                    ? 'O'
                                                    : '',
                                            style: TextStyle(
                                                color: Player.playerX
                                                        .contains(index)
                                                    ? styles.KPrimarySwatch
                                                    : Colors.pink,
                                                fontSize: 40),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...firstbloc(),
                          const SizedBox(
                            height: 15,
                          ),
                          ...secondBloc()
                        ],
                      ),
                    )
                  ],
                )),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);

      UpdateState();
    }

    if (!isSwitched && !gameOver && turn != 9) {
      await game.autoPlay(activePlayer);
      UpdateState();
    }
  }

  void UpdateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer Is The Winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s A Draw';
      }
    });
  }

  List<Widget> firstbloc() {
    return [
      SwitchListTile.adaptive(
        activeColor: Colors.green,
        inactiveThumbColor: Colors.white,
        activeTrackColor: Colors.white,
        value: isSwitched,
        onChanged: (bool newValue) {
          setState(() {
            isSwitched = newValue;
          });
        },
        title: const Text(
          'Turn On / Off Two Players',
          style: TextStyle(fontSize: 20),
        ),
      ),
      Text(
        "It' I's $activePlayer turn",
        style: const TextStyle(fontSize: 26, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 35,
      ),
    ];
  }

  List<Widget> secondBloc() {
    return [
      Text(
        "$result",
        style: const TextStyle(fontSize: 36, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(styles.KSplashColor)),
        onPressed: () {
          setState(() {
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
            Player.playerX = [];
            Player.playerO = [];
          });
        },
        label: const Text(
          'Repeat The Game',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        icon: Icon(
          Icons.repeat,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 50,
      )
    ];
  }
}
