/// Coordinate struct represents a coordinate on the game board.
///
/// It contains two properties x and y for the x and y position on the board, respectively.
/// It also conforms to the Hashable and CustomStringConvertible protocols.
public struct Coordinate : Hashable, CustomStringConvertible {
    /// x-position of the coordinate on the game board.
    var x: Int
    /// y-position of the coordinate on the game board.
    var y: Int
    
    /// Computed property that returns the description of the `Coordinate` object as a string.
    public var description: String {
        "[\(x);\(y)]"
    }
    
    /// Initializes a `Coordinate` object with the given x and y positions.
    ///
    /// - Parameters:
    ///   - x: x-position of the coordinate on the game board.
    ///   - y: y-position of the coordinate on the game board.
    public init(atX x: Int, atY y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Function that enables the use of `Coordinate` as a key in a dictionary.
    ///
    /// - Parameter hasher: The `Hasher` instance to use for hashing.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    /// Operator function that allows for comparison of two `Coordinate` objects.
    ///
    /// - Parameters:
    ///   - lhs: Left-hand side `Coordinate` object to compare.
    ///   - rhs: Right-hand side `Coordinate` object to compare.
    /// - Returns: `true` if the two `Coordinate` objects have the same x and y positions, `false` otherwise.
    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
