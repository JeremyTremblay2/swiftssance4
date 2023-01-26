import Model

func testBoardInsertion(withBoard board: inout Board, withId id: Int, atColumn column: Int) {
    let boardResult = board.insertPiece(from: id, atColumn: column)
    switch (boardResult) {
    case .ok:
        print("Player \(id) has inserted a piece at column \(column).")
    case let .failed(reason):
        switch (reason) {
        case .outOfBounds:
            print("Column \(column) was out of bounds for this board of \(board.numberOfColumns)x\(board.numberOfRows) size. Piece not added.")
        case .columnFull:
            print("The column \(column) was full, impossible to add the piece.")
        case .invalidPlayerId:
            print("The player id given (\(id)) was invalid. Piece not added.")
        default:
            print("Unknow error case, piece not added.")
        }
    default:
        print("Something unusual happened.")
    }
}

func testBoardSuppression(withBoard board: inout Board,  atColumn column: Int) {
    let boardResult = board.removePiece(atColumn: column)
    switch (boardResult) {
    case .ok:
        print("A piece was remove at column \(column).")
    case let .failed(reason):
        switch (reason) {
        case .outOfBounds:
            print("Column \(column) was out of bounds for this board of \(board.numberOfColumns)x\(board.numberOfRows) size. Piece not remove.")
        case .columnEmpty:
            print("There is no piece at the specified column (\(column)). Impossible to remove the piece.")
        default:
            print("Unknow error case, piece not removed.")
        }
    default:
        print("Something unusual happened.")
    }
}

let grid = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, 2, nil, nil, nil, nil],
    [nil, nil, 2, nil, nil, nil, nil],
    [1, 2, 1, 1, nil, nil, nil],
    [2, 1, 2, 2, 1, nil, 1],
    [1, 2, 2, 1, 2, 2, 1]
]

let fullGrid = [
    [1, 2],
    [2,1]
]

if var board = Board(withGrid: grid) {
    print("Here is the board after initializing its size (\(board.numberOfColumns)x\(board.numberOfRows)): \n")
    print(board)
    testBoardInsertion(withBoard: &board, withId: 1, atColumn: 5)
    testBoardInsertion(withBoard: &board, withId: 2, atColumn: 0)
    testBoardInsertion(withBoard: &board, withId: 1, atColumn: 6)
    testBoardInsertion(withBoard: &board, withId: 2, atColumn: 2)
    // Should not work.
    testBoardInsertion(withBoard: &board, withId: 1, atColumn: 2)
    testBoardInsertion(withBoard: &board, withId: 1, atColumn: 7)
    testBoardInsertion(withBoard: &board, withId: 1, atColumn: -1)
    testBoardInsertion(withBoard: &board, withId: 0, atColumn: 0)
    testBoardInsertion(withBoard: &board, withId: 3, atColumn: 0)
    print("Here is the board after all these operations: \n\(board)")
}

if var board = Board(withGrid: grid) {
    print("Here is the board after initializing its size (\(board.numberOfColumns)x\(board.numberOfRows)): \n")
    print(board)
    testBoardInsertion(withBoard: &board, withId: 2, atColumn: 2)
    print("Is column 2 full ? => \(board.isFull(atColumn: 2))\n")
    print("Is column 0 full ? => \(board.isFull(atColumn: 0))\n")
    print("Is column 6 full ? => \(board.isFull(atColumn: 6))\n")
    print("Is column -1 full ? => \(board.isFull(atColumn: -1))\n")
    print("Is column 7 full ? => \(board.isFull(atColumn: 7))\n")
    print("Is this board full ?\n")
    print(board)
    print("=> \(board.isFull())\n")
    if let fullBoard = Board(withGrid: fullGrid) {
        print("Is this board full ?\n")
        print(fullBoard)
        print("=> \(fullBoard.isFull())\n")
    }
}

if var board = Board(withGrid: grid) {
    print("Here is the board after initializing its size (\(board.numberOfColumns)x\(board.numberOfRows)): \n")
    print(board)
    testBoardInsertion(withBoard: &board, withId: 2, atColumn: 2)
    testBoardSuppression(withBoard: &board, atColumn: 5)
    testBoardSuppression(withBoard: &board, atColumn: 0)
    testBoardSuppression(withBoard: &board, atColumn: 0)
    testBoardSuppression(withBoard: &board, atColumn: 0)
    testBoardSuppression(withBoard: &board, atColumn: 1)
    testBoardSuppression(withBoard: &board, atColumn: 2)
    // Should not work.
    testBoardSuppression(withBoard: &board,  atColumn: 0)
    testBoardSuppression(withBoard: &board,  atColumn: 5)
    testBoardSuppression(withBoard: &board,  atColumn: -1)
    testBoardSuppression(withBoard: &board,  atColumn: 7)
    print("Here is the board after all these operations: \n\(board)")
}
