import 'package:hangman_game_working/models/hangmangame.dart';
import 'package:test/test.dart';

void main() {
  group('Test Hangman Constructor', () {
    test('instance variable word should match word given to constructor', () {
      String word = 'glorp';
      final hangmanGame = HangmanGame(word);

      expect(hangmanGame.word, word);
    });

    test('instance variable correct_guess should be empty string initially',
        () {
      String word = 'glorp';
      final hangmanGame = HangmanGame(word);

      expect(hangmanGame.correctGuesses.isEmpty, isTrue);
    });

    test('instance variable wrongGuesses should be empty string initially', () {
      String word = 'glorp';
      final hangmanGame = HangmanGame(word);

      expect(hangmanGame.wrongGuesses.isEmpty, isTrue);
    });
  });

  group('Test Hangman Guessing Behavior', () {
    test('when user guess correctly', () {
      String word = 'garply';
      final hangmanGame = HangmanGame(word);

      String letter = 'a';

      bool wasAbleToMakeGuess = hangmanGame.guess(letter);

      expect(hangmanGame.correctGuesses.contains(letter), isTrue);
      expect(hangmanGame.wrongGuesses.contains(letter), isFalse);
      expect(wasAbleToMakeGuess, isTrue);
    });

    test('when user guess incorrectly', () {
      String word = 'garply';
      final hangmanGame = HangmanGame(word);

      String letter = 'z';

      bool wasAbleToMakeGuess = hangmanGame.guess(letter);

      expect(hangmanGame.correctGuesses.isEmpty, isTrue);
      expect(hangmanGame.wrongGuesses, letter);
      expect(wasAbleToMakeGuess, isTrue);
    });

    test('when user guesses same letter repeatedly (case-insensitive)', () {
      String word = 'garply';
      final hangmanGame = HangmanGame(word);

      // 'a' and 'q' have already been guessed
      hangmanGame.guess('a');
      hangmanGame.guess('q');

      String correctGuessesBeforeRepeating = hangmanGame.correctGuesses;
      String wrongGuessesesBeforeRepeating = hangmanGame.wrongGuesses;

      //guess 'a' again
      bool canGuessAagain = hangmanGame.guess('a');
      expect(hangmanGame.correctGuesses, correctGuessesBeforeRepeating);
      expect(canGuessAagain, isFalse);

      // quess 'q' again
      bool canGuessQagain = hangmanGame.guess('q');
      expect(hangmanGame.wrongGuesses, wrongGuessesesBeforeRepeating);
      expect(canGuessQagain, isFalse);

      //guess 'A' again
      bool canGuessCapitalAagain = hangmanGame.guess('A');
      expect(hangmanGame.correctGuesses, correctGuessesBeforeRepeating);
      expect(canGuessCapitalAagain, isFalse);

      //guess 'Q' again
      bool canGuessCapitalQagain = hangmanGame.guess('Q');
      expect(hangmanGame.wrongGuesses, wrongGuessesesBeforeRepeating);
      expect(canGuessCapitalQagain, isFalse);
    });

    group('invalid guess', () {
      test('user tries empty string', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        //guess empty string
        expect(() => hangmanGame.guess(''), throwsArgumentError);
      });

      test('user tries non letters (a-zA-Z)', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        String nonLetter = '&';
        //guess empty string
        expect(() => hangmanGame.guess(nonLetter), throwsArgumentError);
      });

      test('user tries a null guess', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        //guess empty string
        expect(() => hangmanGame.guess(null), throwsArgumentError);
      });
    });
  });

  group('Test Displaying Blanks with Correct Guesses', () {
    test('word with black with some correct guesses', () {
      String word = 'banana';
      final hangmanGame = HangmanGame(word);

      hangmanGame.guess('b');
      hangmanGame.guess('n');

      String expectedBlackWord = 'b-n-n-';

      expect(hangmanGame.blanksWithCorrectGuesses, expectedBlackWord);
    });

    test('word with black with all wrong guesses', () {
      String word = 'banana';
      final hangmanGame = HangmanGame(word);

      hangmanGame.guess('d');
      hangmanGame.guess('e');
      hangmanGame.guess('f');

      String expectedBlackWord = '------';

      expect(hangmanGame.blanksWithCorrectGuesses, expectedBlackWord);
    });

    test('word with black all letters guessed', () {
      String word = 'banana';
      final hangmanGame = HangmanGame(word);

      hangmanGame.guess('b');
      hangmanGame.guess('a');
      hangmanGame.guess('n');

      String expectedBlackWord = 'banana';

      expect(hangmanGame.blanksWithCorrectGuesses, expectedBlackWord);
    });
  });

  group('Test Game Status', () {
    test('status returns "win" when all letters guessed', () {
      String word = 'win';
      final hangmanGame = HangmanGame(word);

      hangmanGame.guess('w');
      hangmanGame.guess('i');
      hangmanGame.guess('n');

      expect(hangmanGame.status, 'win');
    });

    test('status to return "lose" after 7 incorrect guesses', () {
      String word = 'xyz';
      final hangmanGame = HangmanGame(word);

      // makes 7 incorrect guesses
      hangmanGame.guess('a'); // 1
      hangmanGame.guess('b'); // 2
      hangmanGame.guess('c'); // 3
      hangmanGame.guess('d'); // 4
      hangmanGame.guess('e'); // 5
      hangmanGame.guess('f'); // 6
      hangmanGame.guess('g'); // 7

      expect(hangmanGame.status, 'lose');
    });

    test('status to return "play" if neither win nor lose', () {
      String word = 'play';
      final hangmanGame = HangmanGame(word);

      expect(hangmanGame.status, 'play');

      hangmanGame.guess('p');

      expect(hangmanGame.status, 'play');
    });
  });
}
