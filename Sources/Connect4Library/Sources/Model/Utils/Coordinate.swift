public struct Coordinate : Hashable, CustomStringConvertible {
    var x: Int
    var y: Int
    
    public var description: String {
        "[\(x);\(y)]"
    }
    
    init(atX x: Int, atY y: Int) {
        self.x = x
        self.y = y
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
