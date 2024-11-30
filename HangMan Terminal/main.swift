
import Foundation


// Hangman stages for each incorrect guess
let hangmanStages = [
    """
      
      
      
      
      
      
    """,
    """
      
      
      
      
      
      ______
    """,
    """
      
      |
      |
      |
      |
      |
    __|__
    """,
    """
      -----
      |   |
      |
      |
      |
      |
    __|__
    """,
    """
      -----
      |   |
      |   O
      |
      |
      |
    __|__
    """,
    """
      -----
      |   |
      |   O
      |   |
      |
      |
    __|__
    """,
    """
      -----
      |   |
      |   O
      |  /|\\
      |
      |
    __|__
    """,
    """
      -----
      |   |
      |   O
      |  /|\\
      |  / \\
      |
    __|__
    """
]

// Game setup
let words = ["swift", "developer", "hangman", "programming", "apple", "xcode"]
let wordToGuess = words.randomElement() ?? "swift"  // Selects a random word from the list
let maxAttempts = hangmanStages.count - 1 // Number of hangman stages
var attempts = 0
var guessedLetters = Set<Character>()
var correctGuesses = Set<Character>()

// Helper function to display the current state of the word
func displayWord() -> String {
    var display = ""
    for letter in wordToGuess {
        if correctGuesses.contains(letter) {
            display += "\(letter) "
        } else {
            display += "_ "
        }
    }
    return display.trimmingCharacters(in: .whitespaces)
}

// Game loop
print("Welcome to Hangman!")
print("Try to guess the word!")

while attempts < maxAttempts {
    print("\nWord: \(displayWord())")
    print(hangmanStages[attempts])
    print("Attempts remaining: \(maxAttempts - attempts)")
    print("Guessed letters: \(guessedLetters.sorted())")
    
    // Prompt the user for a letter
    print("Enter a letter:")
    guard let input = readLine()?.lowercased(), let guess = input.first, input.count == 1 else {
        print("Please enter a single letter.")
        continue
    }
    print()
    // Check if the letter has already been guessed
    if guessedLetters.contains(guess) {
        print("You've already guessed '\(guess)'. Try again.")
        continue
    }
    
    // Add the letter to guessedLetters set
    guessedLetters.insert(guess)
    
    print()
    
    // Check if the guessed letter is in the word
    if wordToGuess.contains(guess) {
        print("Good Job!")
        correctGuesses.insert(guess)
    } else {
        print("Sorry, that letter is not in the word.")
        attempts += 1
    }
    
    // Check if the player has guessed all letters in the word
    if correctGuesses.isSuperset(of: Set(wordToGuess)) {
        print("\nCongratulations! You've guessed the word: \(wordToGuess)")
        print(hangmanStages[attempts]) // Show final stage if won early
        break
    }
}

// End of game
if attempts == maxAttempts {
    print("\nGame Over! You've run out of attempts. The word was: \(wordToGuess)")
    print(hangmanStages[attempts]) //Display final Hangman stage
}
