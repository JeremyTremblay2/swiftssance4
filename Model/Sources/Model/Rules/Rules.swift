protocol Rules {
    var minWidth: Int { get }
    var maxWidth: Int { get }
    var minHeight: Int { get }
    var maxHeight: Int { get }
    var winSequence: Int { get }
    
    func checkWin(board: Board) -> GameResult
    func isValid(withPlayerId id: Int, AtColumn column: Int, withBoard board: Board) -> Bool
    func checkHorizontalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?)
    func checkVerticalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?)
    func checkRightDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?)
    func checkLeftDiagonalAlignment(withBoard board: Board, forPlayer playerId: Int) -> (Bool, [Coordinate]?)
}
