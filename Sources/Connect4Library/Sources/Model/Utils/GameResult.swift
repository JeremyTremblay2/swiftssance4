public enum GameResult {
    case winner(Int, [Coordinate])
    case notFinished
    case equality
    
    static func ==(lhs: GameResult, rhs: GameResult) -> Bool {
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
