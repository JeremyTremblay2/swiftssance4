/// Protocol that defines the rules for a game.
public protocol Rules: CustomStringConvertible {
    
    /// The minimum width for the game board.
    var minWidth: Int { get }
    
    /// The maximum width for the game board.
    var maxWidth: Int { get }
    
    /// The minimum height for the game board.
    var minHeight: Int { get }
    
    /// The maximum height for the game board.
    var maxHeight: Int { get }
    
    /// The number of consecutive pieces required to win the game.
    var winSequence: Int { get }
    
    /// The maximum number of attempts allowed for each player.
    var numberMaxOfAttemps: Int { get }
    
    /// The id of the current player.
    var currentPlayerId: Int { get }
    
    /// The number of attempts made by the current player.
    var currentNumberOfAttemps: Int { get }
    
    /// Creates a new game board.
    func createBoard() -> Board
    
    /// Determines if a move is valid at a given column for a given board.
    /// - Parameter column: The column to check.
    /// - Parameter board: The current board state.
    /// - Returns: A boolean indicating if the move is valid.
    func isValid(atColumn column: Int, withBoard board: Board) -> Bool
    
    /// Determines if a player has won the game.
    /// - Parameter board: The current board state.
    /// - Returns: The result of the game (winner, not finished, or draw).
    func checkWin(board: Board) -> GameResult
    
    /// Determines if the game is over.
    /// - Parameter column: The column for the latest move.
    /// - Parameter board: The current board state.
    /// - Returns: The result of the game (winner, not finished, or draw).
    func isGameOver(atColumn column: Int, withBoard board: Board) -> GameResult
}
