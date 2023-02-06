public protocol Rules : CustomStringConvertible {
    var minWidth: Int { get }
    var maxWidth: Int { get }
    var minHeight: Int { get }
    var maxHeight: Int { get }
    var winSequence: Int { get }
    var numberMaxOfAttemps: Int { get }
    var currentPlayerId: Int { get }
    var currentNumberOfAttemps: Int { get }
    
    func createBoard() -> Board
    func isValid(atColumn column: Int, withBoard board: Board) -> Bool
    func checkWin(board: Board) -> GameResult
    // func isGameOver(atColumn column: Int, withBoard board: Board) -> GameResult
}
