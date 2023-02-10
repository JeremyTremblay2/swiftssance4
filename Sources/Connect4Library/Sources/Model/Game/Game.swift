/// Represents a game of the Connect 4.
/// It is an abstract implementtation that does nothing, but it contains the rules, the players and a displayer for thios game.
public class Game {
    /// The first player in the game
    let player1: Player
    
    /// The second player in the game
    let player2: Player
    
    /// The rules for this game
    let rules: Rules
    
    /// The game board
    var board: Board
    
    /// The displayer type used to display the game
    let displayer: (String) -> Void
    
    /**
     Initialize a new game instance with players, rules, and displayer type.
     
     - Parameter player1: The first player in the game.
     - Parameter player2: The second player in the game.
     - Parameter rules: The rules for the game.
     - Parameter displayer: The displayer type used to display the game.
     */
    public init(withPlayer1 player1: Player,
                withPlayer2 player2: Player,
                withRules rules: Rules,
                withDisplayerType displayer: @escaping (String) -> Void) {
        self.player1 = player1
        self.player2 = player2
        self.rules = rules
        self.displayer = displayer
        board = rules.createBoard()
    }
    
    /**
     Play the game.
     */
    public func play() {
        
    }
}
