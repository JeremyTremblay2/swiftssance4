/// Human is a subclass of Player that represents a human player in the game.
/// The human player can make a move by reading input from the console using a scanner.
public class Human : Player {
    /// The way of getting user inputs in the game.
    private let scanner: () -> Int
    
    /// Initializes a new `Human` instance with a given `id`, `name`, and a scanner function that reads input from the console.
    /// - Parameters:
    ///   - id: An integer value representing the unique identifier of the player.
    ///   - name: A string value representing the name of the player.
    ///   - scanner: A function that reas input from the console.
    public init?(withId id: Int, withName name: String, andScanner scanner: @escaping () -> Int) {
        self.scanner = scanner
        super.init(withId: id, withName: name)
        
    }

    /// Makes a move on the given board by reading input from the console using the scanner function.
    /// - Parameter board: The current game board.
    /// - Returns: An integer representing the column number where the move is made.
    public override func play(withBoard board: Board) -> Int {
        return scanner()
    }
}
