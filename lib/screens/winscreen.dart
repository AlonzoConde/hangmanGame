import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game_working/models/hangmangame.dart';
import 'package:hangman_game_working/screens/gamescreen1.dart';

class WinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You Win", key: Key('win-text')),
            SizedBox(
                height: 300,
                child: Image(image: AssetImage('assets/progress_8.png'))),
            RaisedButton(
              key: Key('new-game-btn'),
              child: Text('New Game'),
              onPressed: () {
                HangmanGame game = HangmanGame('banana');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GameScreen(game)));
              },
            )
          ],
        ),
      ),
    ));
  }
}
