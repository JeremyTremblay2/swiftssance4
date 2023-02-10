/// File used to test the Connect 4 game.
/// You can also run some functionnal tests here

import Model

// You can customize the names if you want !
let player1 = Human(withId: 1, withName: "Jérémy", andScanner: input)
let player2 = MinamaxAI(withId: 2, withName: "Hardcore AI", withDifficultyLevel: 1) // Change the level of difficulty by increasing the level of the AI.
let player3 = MinamaxAI(withId: 1, withName: "Hardcore AI 2", withDifficultyLevel: 3)
// Warning: more than 3 will cause the program to be slower, the time that the AI will take to play will exponentially increase.

let g = ConsoleGame(withPlayer1: player1!, withPlayer2: player2!, withRules: rules, withDisplayerType: display)
g.play()

//testBoard()
//testGame()
