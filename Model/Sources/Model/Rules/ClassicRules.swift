public class StandardRules: Rules {
    let minWidth = 5
    let maxWidth = 10
    let minHeight = 5
    let maxHeight = 10
    let winSequence = 4
    var currentPlayerId: Int = 1
    
    public func isValid(withPlayerId id: Int, AtColumn column: Int, withBoard board: Board) -> Bool {
        guard id == 1 || id == 2 || column < maxWidth || column >= 0 || !board.isFull() else {
            return false
        }
        currentPlayerId = (currentPlayerId == 1) ? 2 : 1
        return true
    }
    
    public func checkWin(board: Board) -> GameResult {
        var resultPlayer1 = hasPlayerWon(withBoard: board, from: 1)
        var resultPlayer2 = hasPlayerWon(withBoard: board, from: 2)
        if (resultPlayer1 == GameResult.winner(1, [])) {
            if (resultPlayer2 == GameResult.winner(2, [])) {
                return .equality
            }
            return resultPlayer1
        }
        if (resultPlayer2 == GameResult.winner(2, [])) {
            return resultPlayer2
        }
        
        if board.isFull() {
            return .equality
        }
        
        return .notFinished
    }
    
    public func checkHorizontalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
        for y in 0..<board.numberOfRows {
            var sequenceCount = 0
            var winSequenceStart: [Coordinate] = []
            for x in 0..<board.numberOfColumns {
                if board.theGrid[x][y] == playerId {
                    winSequenceStart.append(Coordinate(atX: x, atY: y))
                    sequenceCount += 1
                    if sequenceCount == winSequence {
                        return (true, winSequenceStart)
                    }
                }
                else {
                    sequenceCount = 0
                    winSequenceStart = []
                }
            }
        }
        return (false, nil)
    }
    
    public func checkVerticalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
        for c in 0..<board.numberOfColumns {
            var sequenceCount = 0
            var winSequenceStart: [Coordinate] = []
            for r in 0..<board.numberOfRows {
                if board.theGrid[r][c] == playerId {
                    sequenceCount += 1
                    winSequenceStart.append(Coordinate(atX: r, atY: c))
                    if sequenceCount == winSequence {
                        return (true, winSequenceStart)
                    }
                }
                else {
                    sequenceCount = 0
                    winSequenceStart = []
                }
            }
        }
        return (false, nil)
    }
    
    public func checkRightDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
        var coordinates: [Coordinate] = []
        for i in 0..<(board.numberOfRows - winSequence + 1) {
            for j in (winSequence - 1)..<(board.numberOfColumns) {
                var count = 0
                var tempCoordinates: [Coordinate] = []
                var x = i
                var y = j
                while x < board.numberOfRows && y >= 0 {
                    if board.theGrid[x][y] == playerId {
                        count += 1
                        tempCoordinates.append(Coordinate(atX: x, atY: y))
                    } else {
                        count = 0
                        tempCoordinates = []
                    }
                    if count == winSequence {
                        coordinates = tempCoordinates
                        return (true, coordinates)
                    }
                    x += 1
                    y -= 1
                }
            }
        }
        return (false, nil)
    }
    
    public func checkLeftDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
        var coordinates: [Coordinate] = []
        for i in 0..<(board.numberOfRows - winSequence + 1) {
            for j in 0..<(board.numberOfColumns - winSequence + 1) {
                var count = 0
                var tempCoordinates: [Coordinate] = []
                var x = i
                var y = j
                while x < board.numberOfRows && y < board.numberOfColumns {
                    if board.theGrid[x][y] == playerId {
                        count += 1
                        tempCoordinates.append(Coordinate(atX: x, atY: y))
                    }
                    else {
                        count = 0
                        tempCoordinates = []
                    }
                    if count == winSequence {
                        coordinates = tempCoordinates
                        return (true, coordinates)
                    }
                    x += 1
                    y += 1
                }
            }
        }
        return (false, nil)
    }
    
    private func hasPlayerWon(withBoard board: Board, from playerId: Int) -> GameResult {
        var result: (Bool, [Coordinate]?) = checkHorizontalAlignment(withBoard: board, forPlayer: playerId)
        if result.0 {
            return .winner(playerId, result.1!)
        }
        result = checkVerticalAlignment(withBoard: board, forPlayer: playerId)
        if result.0 {
            return .winner(playerId, result.1!)
        }
        result = checkRightDiagonalAlignment(withBoard: board, forPlayer: playerId)
        if result.0 {
            return .winner(playerId, result.1!)
        }
        result = checkLeftDiagonalAlignment(withBoard: board, forPlayer: playerId)
        if result.0 {
            return .winner(playerId, result.1!)
        }
        return .notFinished
    }
}
