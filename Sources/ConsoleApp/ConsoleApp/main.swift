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

// You can customize the names if you want !
var player1 = Human(withId: 1, withName: "Jérémy", andScanner: input)
var player2 = AI(withId: 2, withName: "Simple AI")
let rules = ClassicRules()


let g = Game(withPlayer1: player1!, withPlayer2: player2!, withRules: rules, withDisplayerType: display)
g.play()

//testBoard()
