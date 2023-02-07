/// The MinamaxAI class implements the AI protocol and is an implementation of the Minimax algorithm for the game of Connect 4.
/// This AI uses the rules defined in the `ClassicRules` class to determine the validity of a move and the winner of the game.
/// The `play` method returns the best column for the AI to place its piece.
/// The difficulty level can be set through the init method, with a maximum depth of 6.
public class MinamaxAI : AI {
    
    /// The current search depth of the Minimax algorithm.
    public let depth: Int
    
    /// The maximum search depth of the Minimax algorithm.
    private let maxDepth: Int = 6
    
    /// An instance of the `ClassicRules` class to determine the validity of a move and the winner of the game.
    private let rules = ClassicRules()
    
    /// Overrides the `play` method from the AI protocol.
    /// Given a `Board` object, returns the best column for the AI to place its piece.
    override public func play(withBoard board: Board) -> Int {
        var boardCopy = board
        return minMax(board: &boardCopy, depth: depth)
    }
    
    /// Initializer for the MinimaxAI with default difficulty level.
    /// - Parameter id: The unique identifier of the AI.
    /// - Parameter name: The name of the AI.
    public override init?(withId id: Int, withName name: String) {
        depth = maxDepth
        super.init(withId: id, withName: name)
    }
    
    /// Initializer for the MinimaxAI with specified difficulty level.
    /// - Parameter id: The unique identifier of the AI.
    /// - Parameter name: The name of the AI.
    /// - Parameter level: The difficulty level of the AI, with a maximum of 6.
    public init?(withId id: Int, withName name: String, withDifficultyLevel level: Int) {
        guard level > 0 else {
            return nil
        }
        depth = min(level, maxDepth)
        super.init(withId: id, withName: name)
    }
    
    /// The main implementation of the Minimax algorithm.
    /// Given a `Board` object and a search depth, returns the best column for the AI to place its piece.
    func minMax(board: inout Board, depth: Int) -> Int {
        if depth != self.depth {
            let gameResult = rules.checkWin(board: board)
            
            switch (gameResult) {
            case .notFinished:
                break
            case .equality:
                return 0
            case let .winner(playerId, _):
                if playerId == id {
                    return (depth + 1) * 2
                }
                return (depth + 1) * 2
            }
            
            if depth == 0 {
                switch gameResult {
                case .winner(_, _):
                    return 1
                default:
                    return 0
                }
            }
        }
        
        var bestScore = Int.min
        var bestColumn = -1
        for column in 0..<board.numberOfColumns {
            if rules.isValid(atColumn: column, withBoard: board) {
                var newBoard = board
                _ = newBoard.insertPiece(from: id, atColumn: column)
                let score = minMax(board: &newBoard, depth: depth - 1)
                if score > bestScore {
                    bestScore = score
                    bestColumn = column
                }
            }
        }
        for column in 0..<board.numberOfColumns {
            if rules.isValid(atColumn: column, withBoard: board) {
                var newBoard = board
                _ = newBoard.insertPiece(from: id == 1 ? 2 : 1, atColumn: column)
                let score = minMax(board: &newBoard, depth: depth - 1)
                if score > bestScore {
                    bestScore = score
                    bestColumn = column
                }
            }
        }
        return bestColumn
    }
}
