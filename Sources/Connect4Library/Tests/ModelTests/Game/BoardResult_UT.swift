import Model
import XCTest

final class BoardResult_UT: XCTestCase {
    
    func testIsGameOverWithValidInput() throws {
        let grid = [[1, nil, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [2, 1, 2, 1, 2, 1],
                    [1, 2, 1, 2, 1, 2],
                    [1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [1, 2, 1, 2, 1, 1]]
        let gameResult = BoardResult.ok
        
        var board = Board(withGrid: grid)!
        let result = board.insertPiece(from: 1, atColumn: 1)
        
        XCTAssertEqual(result, gameResult)
    }
    
    func testIsGameOverWithInvalidInput() throws {
        let grid = [[1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [2, 1, 2, 1, 2, 1],
                    [1, 2, 1, 2, 1, 2],
                    [1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [1, 2, 1, 2, 2, 2]]
        let gameResult = BoardResult.failed(.columnFull)
        
        var board = Board(withGrid: grid)!
        let result = board.insertPiece(from: 1, atColumn: 0)
        
        XCTAssertEqual(result, gameResult)
    }
    
    func testIsGameOverWithOutOfBoundsInput() throws {
        let grid = [[1, 2, 2, nil, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [2, 1, 2, 1, 2, 1],
                    [1, 2, 1, 2, 1, 2],
                    [1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [1, 2, 1, 2, 2, 2]]
        let gameResult = BoardResult.failed(.outOfBounds)
        
        var board = Board(withGrid: grid)!
        let result = board.insertPiece(from: 1, atColumn: -1)
        
        XCTAssertEqual(result, gameResult)
    }
    
    func testIsGameOverWithOutOfBoundsInput2() throws {
        let grid = [[1, 2, 2, nil, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [2, 1, 2, 1, 2, 1],
                    [1, 2, 1, 2, 1, 2],
                    [1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [1, 2, 1, 2, 2, 2]]
        let gameResult = BoardResult.failed(.outOfBounds)
        
        var board = Board(withGrid: grid)!
        let result = board.insertPiece(from: 1, atColumn: 6)
        
        XCTAssertEqual(result, gameResult)
    }
    
    func testIsGameOverWithInvalidPlayerId() throws {
        let grid = [[1, 2, 2, nil, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [2, 1, 2, 1, 2, 1],
                    [1, 2, 1, 2, 1, 2],
                    [1, 2, 2, 1, 2, 1],
                    [2, 1, 1, 2, 1, 2],
                    [1, 2, 1, 2, 2, 2]]
        let gameResult = BoardResult.failed(.invalidPlayerId)
        
        var board = Board(withGrid: grid)!
        let result = board.insertPiece(from: 0, atColumn: 3)
        
        XCTAssertEqual(result, gameResult)
    }
}

