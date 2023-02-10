/// File used to test the Connect 4 game.
/// You can also run some functionnal tests here

import Model

func display(withMessage message: String) -> Void {
    print(message)
}

func input() -> Int {
    var value: Int?
    repeat {
        let str = readLine()
        value = Int(str ?? "")
    } while value == nil
    return value!
}

let rules = ClassicRules()

func testGame() {
    // You can customize the names if you want !
    let human = Human(withId: 1, withName: "Jérémy", andScanner: input)
    let stupidAI = AI(withId: 2, withName: "Stupid AI")
    let smartAI = MinamaxAI(withId: 1, withName: "Smart AI", withDifficultyLevel: 3) // Change the level of difficulty by increasing the level of the AI.
    // Warning: more than 3 will cause the program to be slower, the time that the AI will take to play will exponentially increase.
    
    display(withMessage: "Here is a game of Connect 4 with just AI ! Fun to watch!")
    let g = Game(withPlayer1: stupidAI!, withPlayer2: smartAI!, withRules: rules, withDisplayerType: display)
    g.play()
}

