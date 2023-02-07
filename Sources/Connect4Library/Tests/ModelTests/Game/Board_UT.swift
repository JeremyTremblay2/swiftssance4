import XCTest
import Model

final class Board_UT : XCTestCase {
    func testInit() throws {
        func expect(initBoardWithnumberOfRows rows: Int, numberOfColumns columns: Int, shouldBeNotNil nilValue: Bool) {
            let board = Board(withNumberOfRows: rows, withNumberOfColumns: columns)
            if  nilValue {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(rows, board?.numberOfRows)
            XCTAssertEqual(columns, board?.numberOfColumns)
        }
        expect(initBoardWithnumberOfRows: 6, numberOfColumns: 7, shouldBeNotNil: false)
        expect(initBoardWithnumberOfRows: 2, numberOfColumns: 3, shouldBeNotNil: false)
        expect(initBoardWithnumberOfRows: 1, numberOfColumns: 10, shouldBeNotNil: false)
        expect(initBoardWithnumberOfRows: 10, numberOfColumns: 1, shouldBeNotNil: false)
        expect(initBoardWithnumberOfRows: 0, numberOfColumns: 0, shouldBeNotNil: true)
        expect(initBoardWithnumberOfRows: 6, numberOfColumns: -1, shouldBeNotNil: true)
        expect(initBoardWithnumberOfRows: -1, numberOfColumns: 7, shouldBeNotNil: true)
        expect(initBoardWithnumberOfRows: -1, numberOfColumns: -1, shouldBeNotNil: true)
    }
    
    func testValidGrid() throws {
        let grid = [[1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil]]
        let board = Board(withGrid: grid)
        XCTAssertNotNil(board)
        XCTAssertEqual(board?.theGrid, grid)
    }

    func testInvalidGridWithFloatingPiece() throws {
        let grid = [[1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [nil, 2, nil, nil, nil, nil, nil]]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }

    func testInvalidGridWithInvalidValue() throws {
        let grid = [[1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [2, 1, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [1, 3, nil, nil, nil, nil, nil]]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }
    
    func testBoardInitWithGridWithFloatingPieces() throws {
        let grid: [[Int?]] = [
            [nil, 2, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, 1, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [1, nil, nil, nil, nil, nil, nil],
            [1, 2, nil, nil, nil, nil, nil],
            [2, 1, nil, nil, nil, nil, nil],
        ]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }
    
    func testBoardInitWithGridWithInvalidPlayerId() throws {
        let grid: [[Int?]] = [
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [1, nil, nil, nil, nil, nil, nil],
            [1, 3, nil, nil, nil, nil, nil],
            [2, 1, nil, nil, nil, nil, nil],
        ]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }
    
    func testBoardInitWithValidGrid() throws {
        let grid: [[Int?]] = [
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [1, nil, nil, nil, nil, nil, nil],
            [2, 1, nil, nil, nil, nil, nil],
            [2, 1, 1, 2, 2, 1, nil],
        ]
        let board = Board(withGrid: grid)
        XCTAssertNotNil(board)
        XCTAssertEqual(board?.theGrid, grid)
    }
    
    func testInvalidBoardSize() throws {
        let grid = [[1,1,1], [1,1]]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }

    func testInvalidBoardWidth() throws {
        let grid = [[1,1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1,1], [1,1,1,1,1,1,1], [1,1,1,1]]
        let board = Board(withGrid: grid)
        XCTAssertNil(board)
    }
    
    func testInsertPiece() throws {
        func expect(board: inout Board, playerId: Int, column: Int, expectedResult: BoardResult) {
            XCTAssertEqual(board.insertPiece(from: playerId, atColumn: column), expectedResult)
        }
        var board = Board(withGrid: [[nil, 1, nil, nil, nil, nil, nil],
                                    [nil, 1, nil, 2, nil, nil, nil],
                                    [nil, 2, nil, 1, 2, nil, 1],
                                    [nil, 1, nil, 1, 2, nil, 2],
                                    [nil, 2, 2, 1, 2, 1, 2],
                                    [2, 1, 1, 2, 2, 1, 1]])
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: -1), .failed(.outOfBounds))
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: 7), .failed(.outOfBounds))
        XCTAssertEqual(board?.insertPiece(from: 3, atColumn: 0), .failed(.invalidPlayerId))
        XCTAssertEqual(board?.insertPiece(from: 0, atColumn: 0), .failed(.invalidPlayerId))
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: 0), .ok)
        XCTAssertEqual(board?.insertPiece(from: 2, atColumn: 6), .ok)
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: 5), .ok)
        XCTAssertEqual(board?.insertPiece(from: 2, atColumn: 4), .ok)
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: 3), .ok)
        XCTAssertEqual(board?.insertPiece(from: 2, atColumn: 2), .ok)
        XCTAssertEqual(board?.insertPiece(from: 1, atColumn: 1), .failed(.columnFull))
    }
    
    func testSubscript() throws {
        var board: Board = Board(withNumberOfRows: 2, withNumberOfColumns: 3)!

        _ = board.insertPiece(from: 1, atColumn: 0)
        _ = board.insertPiece(from: 1, atColumn: 1)
        _ = board.insertPiece(from: 2, atColumn: 1)
        _ = board.insertPiece(from: 1, atColumn: 2)

        XCTAssertEqual(board[0, 0]!, 1)
        XCTAssertNil(board[1, 0])
        XCTAssertEqual(board[0, 1]!, 1)
        XCTAssertEqual(board[1, 1]!, 2)
        XCTAssertEqual(board[0, 2]!, 1)
        XCTAssertNil(board[1, 2])
    }
    
    func testBoardEquality() throws {
        let board1 = Board(withGrid: [[1, 2, nil], [1, 1, 2], [1, 2, 2]])
        let board2 = Board(withGrid: [[1, 2, nil], [1, 1, 2], [1, 2, 2]])
        let board3 = Board(withGrid: [[1, 2, nil], [1, 1, 1], [1, 2, 2]])
        XCTAssertEqual(board1, board2)
        XCTAssertNotEqual(board1, board3)
    }

    func testBoardHash() throws {
        let board1 = Board(withGrid: [[1, 2, nil], [1, 1, 2], [1, 2, 2]])
        let board2 = Board(withGrid: [[1, 2, nil], [1, 1, 2], [1, 2, 2]])
        let board3 = Board(withGrid: [[1, 2, nil], [1, 1, 1], [1, 2, 2]])
        XCTAssertEqual(board1.hashValue, board2.hashValue)
        XCTAssertNotEqual(board1.hashValue, board3.hashValue)
    }

    func testRemovePiece() throws {
        func expect(board: inout Board, column: Int, expectedResult: BoardResult) {
            XCTAssertEqual(board.removePiece(atColumn: column), expectedResult)
        }
        var board = Board(withGrid: [[nil, 1, nil, nil, nil, nil, nil],
                                    [nil, 1, nil, 2, nil, nil, nil],
                                    [nil, 2, nil, 1, 2, nil, 1],
                                    [nil, 1, nil, 1, 2, nil, 2],
                                    [nil, 2, 2, 1, 2, 1, 2],
                                    [2, 1, 1, 2, 2, 1, 1]])
        XCTAssertEqual(board?.removePiece(atColumn: -1), .failed(.outOfBounds))
        XCTAssertEqual(board?.removePiece(atColumn: 7), .failed(.outOfBounds))
        XCTAssertEqual(board?.removePiece(atColumn: 0), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 6), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 5), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 4), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 3), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 2), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 1), .ok)
        XCTAssertEqual(board?.removePiece(atColumn: 0), .failed(.columnEmpty))
    }
    
    func testIsFull() {
        var board = Board(withGrid: [[nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil]])!
        
        XCTAssertFalse(board.isFull())
        for row in 0..<board.theGrid.count {
            for col in 0..<board.theGrid[row].count {
                _ = board.insertPiece(from: 1, atColumn: col)
            }
        }
        XCTAssertTrue(board.isFull())
    }

    func testIsColumnFull() throws {
        // Initialize board with sample grid
        var board = Board(withGrid: [[nil, 1, nil, nil, nil, nil, nil],
                                    [nil, 1, nil, 2, nil, nil, nil],
                                    [nil, 2, nil, 1, 2, nil, 1],
                                    [nil, 1, nil, 1, 2, nil, 2],
                                    [nil, 2, 2, 1, 2, 1, 2],
                                    [2, 1, 1, 2, 2, 1, 1]])!
        // Check if first column is full
        XCTAssertEqual(board.isFull(atColumn: 0), false)

        // Insert pieces into first column until it's full
        for _ in 0...5 {
            _ = board.insertPiece(from: 1, atColumn: 0)
        }
        // Check if first column is full
        XCTAssertEqual(board.isFull(atColumn: 0), true)

        // Check if last column is full
        XCTAssertEqual(board.isFull(atColumn: 6), false)

        // Insert pieces into last column until it's full
        for _ in 0...5 {
            _ = board.insertPiece(from: 2, atColumn: 6)
        }
        // Check if last column is full
        XCTAssertEqual(board.isFull(atColumn: 6), true)

        // Check if invalid column is full
        XCTAssertEqual(board.isFull(atColumn: -1), false)
        XCTAssertEqual(board.isFull(atColumn: 7), false)
    }
}
