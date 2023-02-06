public class Game {
    private let player1: Player
    private let player2: Player
    private let rules: Rules
    private var board: Board
    private let displayer: (String) -> Void
    
    public init(withPlayer1 player1: Player,
                withPlayer2 player2: Player,
                withRules rules: Rules,
                withDisplayerType displayer: @escaping (String) -> Void) {
        self.player1 = player1
        self.player2 = player2
        self.rules = rules
        self.displayer = displayer
        board = rules.createBoard()
    }
    
    public func play() {
        var currentPlayer: Player = rules.currentPlayerId == 1 ? player1 : player2
        var gameNotFinished = true
        var choice = 0
        displayer("Welcome to the Connect 4 game. This game will oppose \(player1) and \(player2).")
        displayer("The rules used are the following: \(rules). Let's start the game!")
        displayer("The first player to play is \(currentPlayer.name). Good luck !\n")
        displayer(board.description)
        while (gameNotFinished) {
            displayer("\(currentPlayer.name) it is your turn. Enter your choice: ")
            choice = currentPlayer.play(withBoard: board)
            if (!rules.isValid(atColumn: choice, withBoard: board)) {
                displayer("\(choice) is not a valid choice!")
            }
            else {
                let result = board.insertPiece(from: currentPlayer.id, atColumn: choice)
                switch result {
                case .ok:
                    displayer("\(currentPlayer.name) has inserted a piece at column \(choice). Here is the board: \n")
                    displayer(board.description)
                case let .failed(reason):
                    switch (reason) {
                    case .outOfBounds:
                        displayer("Column \(choice) is out of bounds for this board of \(board.numberOfColumns)x\(board.numberOfRows) size. Piece not added.")
                    case .columnFull:
                        displayer("The column \(choice) is full, impossible to add the piece.")
                    default:
                        displayer("Impossible to add the piece, please retry.")
                    }
                    if rules.currentNumberOfAttemps == 0 {
                        displayer("Too many bad requests, this is now the turn of the next player!")
                    }
                default:
                    displayer("Something unusual happened, please retry.")
                }
                
                gameNotFinished = processNewPiecesInserted()
                changeCurrentPlayer(withCurrentPlayer: &currentPlayer)
            }
        }
        displayer("Congratulations to all the participants! Bye!")
    }
    
    private func changeCurrentPlayer(withCurrentPlayer player: inout Player) {
        player = (rules.currentPlayerId == 1) ? player1 : player2
    }
    
    fileprivate func processNewPiecesInserted() -> Bool {
        let finalResult = rules.checkWin(board: board)
        switch (finalResult) {
        case .equality:
            displayer("The game is finished and there is an equality! No one won!")
            return false
        case let .winner(winnerId, winCells):
            displayer("The game is finished. \(player1.id == winnerId ? player1.name : player2.name) won this game with this incredible move!")
            displayer("Win cells: \(winCells)")
            return false
        default:
            displayer("Next turn!")
            return true
        }
    }
}
