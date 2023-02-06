/// The `Player` class represents a player in the game.
/// It has an `id` property which is a unique identifier for the player and a `name` property
/// which is the name of the player.
public class Player : CustomStringConvertible {
    
    /// The unique identifier for the player.
    public let id: Int
    
    /// The name of the player.
    public let name: String
    
    /// A human-readable description of the player in the format: `[id] name`.
    public var description: String {
        return "[\(id)] \(name)"
    }
    
    /// Initializes a new player with a given `id` and `name`.
    /// If either `id` is less than 1 or `name` is empty, the initialization will fail and return `nil`.
    public init?(withId id: Int, withName name: String) {
        guard id > 0 && !name.isEmpty else {
            return nil
        }
        self.id = id
        self.name = name
    }
    
    /// This function should be overridden by subclasses to implement the logic of how a player makes a move in the game.
    /// It takes in the current state of the game represented by the `board` and returns the column number where the player wants to make their move.
    public func play(withBoard board: Board) -> Int {
        return 0
    }
}
