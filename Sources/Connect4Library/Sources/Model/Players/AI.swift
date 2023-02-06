/// Represents an AI player in the Coet 4 game.
public class AI : Player {
    /// Returns the AI's next move based on the given `board`.
    ///
    /// The AI makes random moves until it finds an available column. If all columns are full, it returns the last attempted column.
    public override func play(withBoard board: Board) -> Int {
        guard !board.isFull() else {
            return -1
        }
        var tests = 5, columnChoose: Int
        repeat {
            columnChoose = Int.random(in: 0..<board.numberOfColumns)
            tests -= 1
        } while (!board.isFull(atColumn: columnChoose) && tests != 0)
        return columnChoose
    }
}
