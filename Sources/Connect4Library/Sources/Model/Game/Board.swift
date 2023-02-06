/// The `Board` struct implements a Connect Four board game.
/// The board consists of a 2D grid of cells, where each cell can contain an ID of a player (represented as 1 or 2) or `nil` if the cell is empty.
/// The board implements the `CustomStringConvertible` and `Hashable` protocols.
///
/// # Notes
///     - This is the main class of the project.
///     - It contains multiple methods to collect and modify data.
public struct Board: CustomStringConvertible, Hashable {
    /// A default display string to be used when the cell is empty.
    private static let defaultDisplay = "-"
    /// A mapping of player IDs to their correspoding display strings.
    private static let descriptionPlayerIDMapper: [Int?:String] = [nil:".", 1:"X", 2:"O"]
    /// A list of available player IDs.
    private static let availableIds: [Int] = [1, 2]
    /// The number of rows in the board.
    public let numberOfRows: Int
    /// The number of columns in the board.
    public let numberOfColumns: Int

    /// The underlying grid data.
    private var grid: [[Int?]]

    /// A reversed version of the underlying grid, for display purposes.
    public var theGrid: [[Int?]] { grid.reversed() }

    /// A string representation of the board, to be used when the board is printed.
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

    /// Initializes a new board with the specified number of rows and columns.
    /// - Parameter numberOfRows: The number of rows in the board. Defaults to 6.
    /// - Parameter numberOfColumns: The number of columns in the board. Defaults to 7.
    /// - Returns: An optional `Board` object. If either the number of rows or columns is less than 1, `nil` is returned.
    public init?(withNumberOfRows numberOfRows: Int = 6, withNumberOfColumns numberOfColumns: Int = 7) {
        guard numberOfRows > 0 && numberOfColumns > 0 else {
            return nil
        }
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        grid = Array(repeating: Array(repeating: nil, count: numberOfColumns), count: numberOfRows)
    }
    
    /// Initializes a new board with the specified grid.
    /// - Parameter grid: The grid data to be used for the board.
    /// - Returns: An optional `Board` object. If the grid data is empty or the number of columns in each row is incorrect, `nil` is returned.
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

    /// Subscript to get the value of the grid at a specific row and column.
    /// - Parameters:
    ///   - row: The row index of the grid.
    ///   - column: The column index of the grid.
    /// - Returns: The value of the grid at the specified row and column or nil if it is empty.
    public subscript(row: Int, column: Int) -> Int? {
        get {
            // Check if the bounds are valid.
            assert(boundsAreValid(atRow: row, andColumn: column), "Index out of bounds")
            return grid[row][column]
        }
    }
    
    /// Method to insert a piece into the grid at a specific column.
    /// - Parameters:
    ///   - id: The id of the player who wants to insert a piece.
    ///   - column: The column where the player wants to insert a piece.
    /// - Returns: A `BoardResult` indicating the result of the insertion.
    public mutating func insertPiece(from id: Int, atColumn column: Int) -> BoardResult {
        // Check if the column is within the bounds of the grid.
        guard column >= 0 && column < numberOfColumns else {
            return .failed(.outOfBounds)
        }
        // Find the first available row in the column to insert the piece.
        for r in 0..<numberOfRows {
            if grid[r][column] == nil {
                return insertPiece(from: id, atRow: r, andColumn: column)
            }
        }
        // Return .columnFull if the column is full and the piece cannot be inserted.
        return .failed(.columnFull)
    }
    
    /// Method to remove a piece from a specific column.
    /// - Parameters:
    ///   - column: The column from which the piece should be removed.
    /// - Returns: A `BoardResult` indicating the result of the removal.
    public mutating func removePiece(atColumn column: Int) -> BoardResult {
        // Check if the column is within the bounds of the grid.
        guard (0..<numberOfColumns).contains(column) else {
            return .failed(.outOfBounds)
        }
        // Return .columnEmpty if the column is already empty.
        if isEmpty(from: column) {
            return .failed(.columnEmpty)
        }
        // Remove the piece from the top of the column.
        for r in (0..<numberOfRows).reversed() {
            if grid[r][column] != nil {
                grid[r][column] = nil
                return .ok
            }
        }
        // Return .unknown if the removal was not successful.
        return .unknow
    }
    
    /// Method to check if a specific column is full.
    /// - Parameters:
    ///   - column: The column to be checked.
    /// - Returns: `true` if the column is full, `false` otherwise.
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
    
    /// Determines if the board is full by checking if all columns are full.
    /// - Returns: A Boolean indicating whether the board is full.
    public func isFull() -> Bool {
        for c in 0..<numberOfColumns {
            if !isFull(atColumn: c) {
                return false
            }
        }
        return true
    }
    
    /// Attempts to insert a piece into the board at the specified row and column.
    /// - Parameters:
    ///   - id: The id of the player who is inserting the piece.
    ///   - row: The row where the piece will be inserted.
    ///   - column: The column where the piece will be inserted.
    /// - Returns: A `BoardResult` indicating the result of the insertion.
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
    
    /// Determines if the grid is valid by checking if each cell contains a valid id.
    /// - Parameter grid: The grid to be checked.
    /// - Returns: A Boolean indicating whether the grid is valid.
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
    
    /// Determines if a column is empty by checking if any cell in the column contains a value.
    /// - Parameter column: The column to be checked.
    /// - Returns: A Boolean indicating whether the column is empty.
    private func isEmpty(from column: Int) -> Bool {
        for r in 0..<numberOfRows {
            if grid[r][column] != nil {
                return false
            }
        }
        return true
    }
    
    /// Determines if the specified row and column are within the bounds of the board.
    /// - Parameters:
    ///   - row: The row to be checked.
    ///   - column: The column to be checked.
    /// - Returns: A Boolean indicating whether the specified row and column are within the bounds of the board.
    private func boundsAreValid(atRow row: Int, andColumn column: Int) -> Bool {
        return row >= 0 && row < numberOfRows && column >= 0 && column < numberOfColumns
    }
    
    /// Overrides the equality operator to compare two Board instances.
    /// Returns true if the grid arrays of both instances are equal, false otherwise.
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
    
    /// Implements the Hashable protocol by hashing the grid array.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(grid)
    }
}
