import XCTest
import Model

final class ClassicRules_UT : XCTestCase {
    private let classicRules = ClassicRules()
    
    func testMinWidth() throws {
        XCTAssertEqual(classicRules.minWidth, 7)
    }

    func testMaxWidth() throws {
        XCTAssertEqual(classicRules.maxWidth, 7)
    }

    func testMinHeight() throws {
        XCTAssertEqual(classicRules.minHeight, 6)
    }

    func testMaxHeight() throws {
        XCTAssertEqual(classicRules.maxHeight, 6)
    }

    func testWinSequence() throws {
        XCTAssertEqual(classicRules.winSequence, 4)
    }

    func testNumberMaxOfAttempts() throws {
        XCTAssertEqual(classicRules.numberMaxOfAttemps, 3)
    }

    func testCurrentPlayerId() throws {
        XCTAssertEqual(classicRules.currentPlayerId, 1)
    }

    func testCurrentNumberOfAttempts() throws {
        XCTAssertEqual(classicRules.currentNumberOfAttemps, 0)
    }

    func testCreateBoard() throws {
        let board = classicRules.createBoard()
        XCTAssertEqual(board.numberOfColumns, 7)
        XCTAssertEqual(board.numberOfRows, 6)
    }

    func testIsValid() throws {
        var board = classicRules.createBoard()
        XCTAssertTrue(classicRules.isValid(atColumn: 3, withBoard: board))
        XCTAssertFalse(classicRules.isValid(atColumn: -1, withBoard: board))
        XCTAssertFalse(classicRules.isValid(atColumn: 7, withBoard: board))
        for _ in 0..<6 {
            _ = board.insertPiece(from: 1, atColumn: 0)
        }
        XCTAssertFalse(classicRules.isValid(atColumn: 0, withBoard: board))
    }

    func testChangePlayerOrder() throws {
        let board = classicRules.createBoard()
        let oldPlayerId = classicRules.currentPlayerId
        _ = classicRules.isValid(atColumn: 0, withBoard: board)
        let newPlayerId = classicRules.currentPlayerId
        XCTAssertNotEqual(oldPlayerId, newPlayerId)
    }
    
    func testcheckWin() throws {
        func expect(initBoardWithGrid grid: [[Int?]],
                    expectedGameResult gameResult: GameResult) {
            let classicRules = ClassicRules()
            let board = Board(withGrid: grid)!
            let result = classicRules.checkWin(board: board)
            XCTAssertEqual(gameResult, result, "The results are not equals")
            if case let .winner(expectedId, expectedCells) = gameResult {
                if case let .winner(id, cells) = result {
                    XCTAssertEqual(expectedId, id, "The player ids are not the same")
                    XCTAssertTrue(expectedCells.allSatisfy(cells.contains), "The cells are not the same")
                }
            }
        }
        
        
        let testCases: [(grid: [[Int?]], expectedResult: GameResult)] = [
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 1, nil, nil, nil]],
             expectedResult: .winner(1, [Coordinate(atX: 0, atY: 5),
                                          Coordinate(atX: 1, atY: 5),
                                          Coordinate(atX: 2, atY: 5),
                                          Coordinate(atX: 3, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 2, 2, 2, 2]],
             expectedResult: .winner(2, [Coordinate(atX: 3, atY: 5),
                                          Coordinate(atX: 4, atY: 5),
                                          Coordinate(atX: 5, atY: 5),
                                          Coordinate(atX: 6, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 2, 1, 1, 1]],
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 2, 2, 2, 2, 2, nil]],
             expectedResult: .winner(2, [Coordinate(atX: 1, atY: 5),
                                         Coordinate(atX: 2, atY: 5),
                                         Coordinate(atX: 3, atY: 5),
                                         Coordinate(atX: 4, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 1, 1, 1, 1, nil, nil],
                    [1, 2, 2, 1, 2, 2, nil],
                    [1, 1, 2, 1, 2, 1, nil]],
             expectedResult: .winner(1, [Coordinate(atX: 1, atY: 3),
                                          Coordinate(atX: 2, atY: 3),
                                          Coordinate(atX: 3, atY: 3),
                                          Coordinate(atX: 4, atY: 3)])),
            
            // VERTICAL
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, 1, nil, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 1, 2],
                    [nil, nil, nil, 1, 2, 2, 2]],
             expectedResult: .winner(1, [Coordinate(atX: 3, atY: 2),
                                         Coordinate(atX: 3, atY: 3),
                                         Coordinate(atX: 3, atY: 4),
                                          Coordinate(atX: 3, atY: 5)])),
            
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             expectedResult: .winner(2, [Coordinate(atX: 4, atY: 0),
                                         Coordinate(atX: 4, atY: 1),
                                         Coordinate(atX: 4, atY: 2),
                                          Coordinate(atX: 4, atY: 3)])),
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 1, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, 1, 2, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             expectedResult: .equality),
             // Right diagonal
             
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, nil, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .winner(1, [Coordinate(atX: 0, atY: 2),
                                         Coordinate(atX: 1, atY: 3),
                                         Coordinate(atX: 2, atY: 4),
                                          Coordinate(atX: 3, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [2, nil, nil, 2, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [1, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .winner(2, [Coordinate(atX: 0, atY: 5),
                                         Coordinate(atX: 1, atY: 4),
                                         Coordinate(atX: 2, atY: 3),
                                          Coordinate(atX: 3, atY: 2)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 2, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .winner(2, [Coordinate(atX: 4, atY: 5),
                                         Coordinate(atX: 3, atY: 4),
                                         Coordinate(atX: 2, atY:3),
                                          Coordinate(atX: 1, atY: 2)])),
            (grid: [[nil, nil, 1, 2, nil, nil, nil],
                    [1, nil, 1, 2, 2, 1, 1],
                    [1, 1, 2, 1, 1, 2, 1],
                    [2, 2, 1, 2, 1, 2, 2],
                    [1, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .winner(2, [Coordinate(atX: 6, atY: 3),
                                         Coordinate(atX: 5, atY: 2),
                                         Coordinate(atX: 4, atY: 1),
                                          Coordinate(atX: 3, atY: 0)])),
            (grid: [[nil, nil, 1, 1, nil, nil, nil],
                    [1, nil, 1, 1, 2, 1, 1],
                    [1, 1, 2, 2, 1, 2, 1],
                    [2, 2, 1, 2, 1, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             expectedResult: .equality)
        ]
        
        for testCase in testCases {
            expect(initBoardWithGrid: testCase.grid, expectedGameResult: testCase.expectedResult)
        }
    }
    
    func testIsGameOver() throws {
        func expect(initBoardWithGrid grid: [[Int?]],
                    expectedGameResult gameResult: GameResult,
                    atColumn column: Int) {
            let classicRules = ClassicRules()
            let board = Board(withGrid: grid)!
            let result = classicRules.isGameOver(atColumn: column, withBoard: board)
            XCTAssertEqual(gameResult, result, "The results are not equals")
            if case let .winner(expectedId, expectedCells) = gameResult {
                if case let .winner(id, cells) = result {
                    XCTAssertEqual(expectedId, id, "The player ids are not the same")
                    XCTAssertTrue(expectedCells.allSatisfy(cells.contains), "The cells are not the same")
                }
            }
        }
        
        
        let testCases: [(grid: [[Int?]], column: Int, expectedResult: GameResult)] = [
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 1, nil, nil, nil]],
             column: 2,
             expectedResult: .winner(1, [Coordinate(atX: 0, atY: 5),
                                          Coordinate(atX: 1, atY: 5),
                                          Coordinate(atX: 2, atY: 5),
                                          Coordinate(atX: 3, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 2, 2, 2, 2]],
             column: 6,
             expectedResult: .winner(2, [Coordinate(atX: 3, atY: 5),
                                          Coordinate(atX: 4, atY: 5),
                                          Coordinate(atX: 5, atY: 5),
                                          Coordinate(atX: 6, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, 2, 1, 1, 1]],
             column: 1,
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 2, 2, 2, 2, 2, nil]],
             column: 2,
             expectedResult: .winner(2, [Coordinate(atX: 1, atY: 5),
                                         Coordinate(atX: 2, atY: 5),
                                         Coordinate(atX: 3, atY: 5),
                                         Coordinate(atX: 4, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 1, 1, 1, 1, nil, nil],
                    [1, 2, 2, 1, 2, 2, nil],
                    [1, 1, 2, 1, 2, 1, nil]],
             column: 3,
             expectedResult: .winner(1, [Coordinate(atX: 1, atY: 3),
                                          Coordinate(atX: 2, atY: 3),
                                          Coordinate(atX: 3, atY: 3),
                                          Coordinate(atX: 4, atY: 3)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, 2, nil, nil, nil, nil],
                    [nil, 1, 1, 1, 1, nil, nil],
                    [1, 2, 2, 1, 2, 2, nil],
                    [1, 1, 2, 1, 2, 1, nil]],
             column: 2,
             expectedResult: .notFinished),
            
            // VERTICAL
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, 1, nil, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 1, 2],
                    [nil, nil, nil, 1, 2, 2, 2]],
             column: 3,
             expectedResult: .winner(1, [Coordinate(atX: 3, atY: 2),
                                         Coordinate(atX: 3, atY: 3),
                                         Coordinate(atX: 3, atY: 4),
                                          Coordinate(atX: 3, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, 1, nil, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 1, 2],
                    [nil, 1, nil, 1, 2, 2, 2]],
             column: 1,
             expectedResult: .notFinished),
            
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             column: 4,
             expectedResult: .winner(2, [Coordinate(atX: 4, atY: 0),
                                         Coordinate(atX: 4, atY: 1),
                                         Coordinate(atX: 4, atY: 2),
                                          Coordinate(atX: 4, atY: 3)])),
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 1, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             column: 4,
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, nil, 2, nil, nil],
                    [nil, nil, nil, 1, 2, nil, nil],
                    [nil, nil, nil, 1, 2, 2, 2],
                    [nil, nil, nil, 1, 1, 2, 1],
                    [nil, nil, nil, 1, 2, 1, 1]],
             
             column: 4,
             expectedResult: .winner(2, [Coordinate(atX: 4, atY: 0),
                                         Coordinate(atX: 4, atY: 1),
                                         Coordinate(atX: 4, atY: 2),
                                          Coordinate(atX: 4, atY: 3)])),
             // Right diagonal
             
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, nil, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 0,
             expectedResult: .winner(1, [Coordinate(atX: 0, atY: 2),
                                         Coordinate(atX: 1, atY: 3),
                                         Coordinate(atX: 2, atY: 4),
                                          Coordinate(atX: 3, atY: 5)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [2, nil, nil, 2, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [1, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 2,
             expectedResult: .winner(2, [Coordinate(atX: 0, atY: 5),
                                         Coordinate(atX: 1, atY: 4),
                                         Coordinate(atX: 2, atY: 3),
                                          Coordinate(atX: 3, atY: 2)])),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 2, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 1,
             expectedResult: .winner(2, [Coordinate(atX: 4, atY: 5),
                                         Coordinate(atX: 3, atY: 4),
                                         Coordinate(atX: 2, atY:3),
                                          Coordinate(atX: 1, atY: 2)])),
            (grid: [[nil, nil, 1, 2, nil, nil, nil],
                    [1, nil, 1, 2, 2, 1, 1],
                    [1, 1, 2, 1, 1, 2, 1],
                    [2, 2, 1, 2, 1, 2, 2],
                    [1, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 3,
             expectedResult: .winner(2, [Coordinate(atX: 6, atY: 3),
                                         Coordinate(atX: 5, atY: 2),
                                         Coordinate(atX: 4, atY: 1),
                                          Coordinate(atX: 3, atY: 0)])),
            (grid: [[nil, nil, 1, 1, nil, nil, nil],
                    [1, nil, 1, 1, 2, 1, 1],
                    [1, 1, 2, 2, 1, 2, 1],
                    [2, 2, 1, 2, 1, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 0,
             expectedResult: .notFinished),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 2, nil, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 1,
             expectedResult: .winner(2, [Coordinate(atX: 1, atY: 2),
                                         Coordinate(atX: 2, atY: 3),
                                         Coordinate(atX: 3, atY: 4),
                                          Coordinate(atX: 4, atY: 5)])),
        ]
        
        for testCase in testCases {
            expect(initBoardWithGrid: testCase.grid, expectedGameResult: testCase.expectedResult, atColumn: testCase.column)
        }
    }
}
