class HangmanGame {
  String word;
  String correctGuesses;
  String wrongGuesses;

  // Whenever youre making a new Hangman Game, you can initialize
  // the word you want the player to guess
  HangmanGame(this.word) {
    correctGuesses = "";
    wrongGuesses = "";
  }

  // Everytime the player types in a character, this function will be called
  // to check whether the character is valid and adds it to either the
  // correctGuesses or wrongGuesses String.
  bool guess(String letter) {
    // REgular Expression that only allows for upper/lower case characters
    final validCharacters = RegExp("[a-zA-Z]");

    // First two checks if theres even a character to check after player
    // wants to make a guess
    if (letter == null) {
      throw new ArgumentError();
    }
    if (letter.isEmpty) {
      throw new ArgumentError();
    }

    // If character doesn't match our RegEx, then it will throw an error activating an
    // event to occur
    if (!validCharacters.hasMatch(letter)) {
      throw new ArgumentError();
    }

    // If the letter is in the word, then it will add it to the list of correct characters
    if (correctGuesses.contains(letter.toLowerCase()) ||
        correctGuesses.contains(letter.toUpperCase())) {
      return false;
    }
    // If the character is valid, but doesn't belong to the word, then it will
    // be added to the list of wrong characters
    if (wrongGuesses.contains(letter.toLowerCase()) ||
        wrongGuesses.contains(letter.toUpperCase())) {
      return false;
    }

    // Checks if a correct guess has already been added to the correctGuess String
    if (word.contains(letter)) {
      // If not, then the letter will be added to the correctGueses String
      if (!correctGuesses.contains(letter)) {
        correctGuesses += letter;
      }
      // If letter is already guessed, then nothing will happen and game will continue
      return true;
    }
    // Opposite to previous statement
    else {
      // Same here to previous statement
      if (!wrongGuesses.contains(letter)) {
        //throw new ArgumentError();
        wrongGuesses += letter;
      }
      // Also here
      return true;
    }
  }

  String get blanksWithCorrectGuesses {
    // Create an array that is the same size as the word that is being guessed
    List<String> blank = new List(word.length);
    String tmp = "";

    // Fill created array with dashes. Ex: "apple == -----"
    for (int i = 0; i < word.length; ++i) {
      blank[i] = "-";
    }

    // If the user doesn;t have any correct guesses, tmp will be filled with dashes
    if (correctGuesses.isEmpty == true) {
      for (int i = 0; i < word.length; ++i) {
        tmp += blank[i];
      }
    }

    // If the player has gueesed a correct letter, fill in the letter in place of the dash
    // Guessed word == "apple"
    // Correct guesses == "p" "e"
    // blank == "-pp-e"
    else {
      for (int i = 0; i < word.length; ++i) {
        for (int j = 0; j < correctGuesses.length; ++j) {
          if (word[i] == correctGuesses[j]) {
            blank[i] = word[i];
          }
        }
      }
      // Copy contents of "blank" array into Sting tmp because of return type
      for (int i = 0; i < blank.length; ++i) {
        tmp += blank[i];
      }
    }
    // "tmp" now contains the string with the correct guessed letters in their
    // corresponding locations.
    return tmp;
  }

// Fucntion that returns the status of the game.
// Lose checks if the amount of wrong guesses is at 7
// Win checks if the blanksWithCorrectGuesses is the same as the word youre guessing
// Anything else will leave player on game screen
  String get status {
    if (wrongGuesses.length >= 7) {
      return 'lose';
    } else if (blanksWithCorrectGuesses == word) {
      return 'win';
    } else {
      return 'play';
    }
  }
}
