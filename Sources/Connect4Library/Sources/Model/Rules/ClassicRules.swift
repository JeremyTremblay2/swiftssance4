public class ClassicRules: Rules {
    public let minWidth = 7
    public let maxWidth = 7
    public let minHeight = 6
    public let maxHeight = 6
    public let winSequence = 4
    public let numberMaxOfAttemps = 3
    public private (set) var currentPlayerId: Int = 1
    public private (set) var currentNumberOfAttemps = 0
    
    public var description: String = "Classic Rules"
    
    public init() {
        
    }
    
    public func createBoard() -> Board {
        return Board(withNumberOfRows: 6, withNumberOfColumns: 7)!
    }
    
    public func isValid(atColumn column: Int, withBoard board: Board) -> Bool {
        guard column < maxWidth || column >= 0 || !board.isFull() else {
            currentNumberOfAttemps += 1
            if currentNumberOfAttemps == numberMaxOfAttemps {
                changePlayerOrder()
            }
            return false
        }
        changePlayerOrder()
        return true
    }
    
    public func checkWin(board: Board) -> GameResult {
        let resultPlayer1 = hasPlayerWon(withBoard: board, from: 1)
        let resultPlayer2 = hasPlayerWon(withBoard: board, from: 2)
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
    
    private func checkHorizontalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
        for y in 0..<board.numberOfRows {
            var sequenceCount = 0
            var winSequenceStart: [Coordinate] = []
            for x in 0..<board.numberOfColumns {
                if board.theGrid[y][x] == playerId {
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
    
    private func checkVerticalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
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
    
    private func checkRightDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
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
    
    private func checkLeftDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?) {
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
    
    private func changePlayerOrder() {
        currentNumberOfAttemps = 0
        currentPlayerId = (currentPlayerId == 1) ? 2 : 1
    }
}
