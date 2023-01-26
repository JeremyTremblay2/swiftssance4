public struct Board : CustomStringConvertible, Hashable {
    private static let defaultDisplay = "-"
    private static let descriptionPlayerIDMapper: [Int?:String] = [nil:" ", 1:"X", 2:"O"]
    private static let availableIds: [Int] = [1, 2]
    public let numberOfRows: Int
    public let numberOfColumns: Int
    
    var grid: [[Int?]]
    
    public var theGrid: [[Int?]] { grid.reversed() }
    
    public var description: String {
        let dashes = String(repeating: "-", count: numberOfColumns * 4 + 1)
        var string = String("\(dashes)\n")
        for row in grid.reversed() {
            string.append("|")
            for column in row {
                string.append(" \(Board.descriptionPlayerIDMapper[column] ?? Board.defaultDisplay) |")
            }
            string.append("\n")
            string.append("\(dashes)\n")
        }
        return string
    }
    
    public init?(withNumberOfRows numberOfRows: Int = 6, withNumberOfColumns numberOfColumns: Int = 7) {
        guard numberOfRows > 0 && numberOfColumns > 0 else {
            return nil
        }
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        grid = Array(repeating: Array(repeating: nil, count: numberOfColumns), count: numberOfRows)
    }
    
    public init?(withGrid grid: [[Int?]]) {
        guard grid.count > 0 && grid[0].count > 0 else {
            return nil
        }
        let result = grid.allSatisfy { $0.count == grid[0].count }
        guard result else {
            return nil
        }
        
        numberOfRows = grid.count
        numberOfColumns = grid[0].count
        self.grid = grid.reversed()
        
        if !isGridValid(from: grid) {
            return nil
        }
    }
    
    public subscript(row: Int, column: Int) -> Int? {
        get {
            assert(boundsAreValid(atRow: row, andColumn: column), "Index out of bounds")
            // Does not works in the subscript because the signature not precise that this scope can throw errors.
            // throw Error()
            return grid[row][column]
        }
    }
    
    public mutating func insertPiece(from id: Int, atColumn column: Int) -> BoardResult {
        guard column >= 0 && column < numberOfColumns else {
            return .failed(.outOfBounds)
        }
        for r in 0..<numberOfRows {
            if grid[r][column] == nil {
                return insertPiece(from: id, atRow: r, andColumn: column)
            }
        }
        return .failed(.columnFull)
    }
    
    public mutating func removePiece(atColumn column: Int) -> BoardResult {
        guard (0..<numberOfColumns).contains(column) else {
            return .failed(.outOfBounds)
        }
        if isEmpty(from: column) {
            return .failed(.columnEmpty)
        }
        // Used to check if the piece is at the top of the grid. If it is not the case, cancel the action.
        for r in (0..<numberOfRows).reversed() {
            if grid[r][column] != nil {
                grid[r][column] = nil
                return .ok
            }
        }
        return .unknow
    }
    
    public func isFull(atColumn column: Int) -> Bool {
        guard column >= 0 && column < numberOfColumns else {
            return false
        }
        for r in 0..<numberOfRows {
            if grid[r][column] == nil {
                return false
            }
        }
        return true
    }
    
    public func isFull() -> Bool {
        for c in 0..<numberOfColumns {
            if !isFull(atColumn: c) {
                return false
            }
        }
        return true
    }
    
    private mutating func insertPiece(from id: Int, atRow row: Int, andColumn column: Int) -> BoardResult {
        guard Board.availableIds.contains(id) else {
            return .failed(.invalidPlayerId)
        }
        guard boundsAreValid(atRow: row, andColumn: column) else {
            return .failed(.outOfBounds)
        }
        grid[row][column] = id
        return .ok
    }
    
    private func isGridValid(from grid: [[Int?]]) -> Bool {
        var valueWasFound: Bool
        for c in 0..<numberOfColumns {
            valueWasFound = false
            for r in (0..<numberOfRows).reversed() {
                if grid[r][c] != nil && !Board.availableIds.contains(grid[r][c]!) {
                    return false
                }
                if r != (numberOfRows-1) && !valueWasFound && grid[r][c] != nil {
                    return false
                }
                valueWasFound = grid[r][c] != nil
            }
        }
        return true
    }
    
    private func isEmpty(from column: Int) -> Bool {
        for r in 0..<numberOfRows {
            if grid[r][column] != nil {
                return false
            }
        }
        return true
    }
    
    private func boundsAreValid(atRow row: Int, andColumn column: Int) -> Bool {
        return row >= 0 && row < numberOfRows && column >= 0 && column < numberOfColumns
    }
    
    public static func == (lhs: Board, rhs: Board) -> Bool {
        for i in 0..<lhs.numberOfRows {
            for j in 0..<lhs.numberOfColumns {
                if lhs.grid[i][j] != rhs.grid[i][j] {
                    return false
                }
            }
        }
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(grid)
    }
}
