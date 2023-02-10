/// ConsoleGame is a subclass of Game class. It represents a Connect 4 game played in the console.
///
/// The class implements the play method to play the game. It prints out the game rules and displays the board in the console.
/// It also takes inputs from the current player and prints the result of their turn.
/// It repeats this process until the game is either finished or a winner is found.
/// The changeCurrentPlayer method changes the current player.
/// The processNewPiecesInserted method processes the new pieces inserted and checks if the game is finished or there is a winner.
public class ConsoleGame: Game {
    
    /// The play method starts the game. It displays the game rules, the board, and takes input from the current player.
    /// It repeats this process until the game is either finished or a winner is found.
    public override func play() {
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
                if rules.currentNumberOfAttemps == 0 {
                    displayer("Too many bad requests, this is now the turn of the next player!")
                }
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
                    
                default:
                    displayer("Something unusual happened, please retry.")
                }
                
                gameNotFinished = processNewPiecesInserted(withPieceInsertedAt: choice)
            }
            changeCurrentPlayer(withCurrentPlayer: &currentPlayer)
        }
        displayer("Congratulations to all the participants! Bye!")
    }
    
    /// This method updates the current player based on the `rules` object.
    ///
    /// - Parameter player: The reference to the current player.
    private func changeCurrentPlayer(withCurrentPlayer player: inout Player) {
        player = (rules.currentPlayerId == 1) ? player1 : player2
    }

    /// This method processes the new pieces inserted into the game and updates the game status based on the result of `rules.checkWin(board: board)`
    ///
    /// - Parameter column: The column where the piece was inserted.
    /// - Returns: A boolean indicating whether the game is finished (`false`) or not (`true`).
    fileprivate func processNewPiecesInserted(withPieceInsertedAt column: Int) -> Bool {
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
