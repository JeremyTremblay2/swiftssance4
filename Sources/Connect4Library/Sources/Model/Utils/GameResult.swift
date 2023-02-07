/// Represents the result of the game of Connect Four.
public enum GameResult : Hashable {
    /// Indicates that a player has won, taking the player's identifier and the coordinates of their winning sequence as arguments.
    case winner(Int, [Coordinate])
    /// Indicates that the game has not yt finished.
    case notFinished
    /// Indicates that the game ended in a draw.
    case equality

    /// Compares two `GameResult` values and returns `true` if they are equal, `false` otherwise.
    public static func ==(lhs: GameResult, rhs: GameResult) -> Bool {
        switch (lhs, rhs) {
        case (.notFinished, .notFinished), (.equality, .equality):
            return true
        case let (.winner(id1, _), .winner(id2, _)):
            return id1 == id2
        default:
            return false
        }
    }
}
