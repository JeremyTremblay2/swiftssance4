public class AI : Player {
    public override func play(withBoard board: Board) -> Int {
        var tests = 5, columnChoose: Int
        repeat {
            columnChoose = Int.random(in: 0..<board.numberOfColumns)
            tests -= 1
        } while (!board.isFull(atColumn: columnChoose) && tests != 0)
        return columnChoose
    }
}
