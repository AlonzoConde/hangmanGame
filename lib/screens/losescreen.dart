import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game_working/screens/gamescreen1.dart';
import 'package:hangman_game_working/models/hangmangame.dart';

class LoseScreen extends StatelessWidget {
  HangmanGame game;
  //This should be modified to take in a HangmanGame
  LoseScreen(this.game);

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You Lose", key: Key('lose-text')),
            SizedBox(
                height: 300,
                child: Image(image: AssetImage('assets/progress_7.png'))),
            Text('word was: ${game.word}'),
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
