public class MinamaxAI : AI {
    private let depth: Int
    private let maxDepth: Int = 10
    private let rules = ClassicRules()
    
    override public func play(withBoard board: Board) -> Int {
        return minMax(board: board, depth: 4, isMaximizingPlayer: true)
    }
    
    public override init?(withId id: Int, withName name: String) {
        depth = maxDepth
        super.init(withId: id, withName: name)
    }
    
    public init?(withId id: Int, withName name: String, withDifficultyLevel level: Int) {
        guard level > 0 else {
            return nil
        }
        depth = min(level, maxDepth)
        super.init(withId: id, withName: name)
    }
    
    func minMax(board: Board, depth: Int, isMaximizingPlayer: Bool) -> Int {
        let gameResult = rules.checkWin(board: board)
        
        if gameResult != .notFinished {
            if gameResult == .equality {
                return 0
            } else if gameResult == .winner(1, []) {
                return Int.max
            } else {
                return Int.min
            }
        }
        
        if depth == 0 {
            return score(forBoard: board, withDepth: depth, withMaximizingPlayer: isMaximizingPlayer)
        }
        
        if isMaximizingPlayer {
            var bestScore = Int.min
            var bestColumn = -1
            for column in 0..<board.numberOfColumns {
                if rules.isValid(atColumn: column, withBoard: board) {
                    var newBoard = board
                    _ = newBoard.insertPiece(from: 1, atColumn: column)
                    let score = minMax(board: newBoard, depth: depth - 1, isMaximizingPlayer: false)
                    if score > bestScore {
                        bestScore = score
                        bestColumn = column
                    }
                }
            }
            return bestColumn
        } else {
            var bestScore = Int.max
            var bestColumn = -1
            for column in 0..<board.numberOfColumns {
                if rules.isValid(atColumn: column, withBoard: board) {
                    var newBoard = board
                    _ = newBoard.insertPiece(from: 2, atColumn: column)
                    let score = minMax(board: newBoard, depth: depth - 1, isMaximizingPlayer: true)
                    if score < bestScore {
                        bestScore = score
                        bestColumn = column
                    }
                }
            }
            return bestColumn
        }
    }
        
    private func score(forBoard board: Board, withDepth depth: Int, withMaximizingPlayer maximizingPlayerId: Bool) -> Int {
        let result = rules.checkWin(board: board)
        switch result {
        case .winner(let playerId, _):
            if playerId != id {
                return depth - maxDepth
            }
            else {
                return maxDepth - depth
            }
        case .equality:
            return 1
        case .notFinished:
            return 0
        }
    }
}
