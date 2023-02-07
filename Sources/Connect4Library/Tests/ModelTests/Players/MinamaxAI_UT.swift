import Model
import XCTest

final class MinamaxAI_UT : XCTestCase {
    func testInitWithIdAndNameAndDifficultyLevel() throws {
        let level = 4
        let ai = MinamaxAI(withId: 1, withName: "Test AI", withDifficultyLevel: level)
        XCTAssertNotNil(ai)
        XCTAssertEqual(ai?.depth, min(level, 6))
        
        let negativeLevel = -2
        let negativeAi = MinamaxAI(withId: 1, withName: "Test AI", withDifficultyLevel: negativeLevel)
        XCTAssertNil(negativeAi)
    }
    
    func testInitWithIdAndName() throws {
        let ai = MinamaxAI(withId: 1, withName: "Test AI")
        XCTAssertNotNil(ai)
        XCTAssertEqual(ai?.depth, 6)
    }
    
    func testPlayWithBoard() throws {
        let ai = MinamaxAI(withId: 1, withName: "Test AI", withDifficultyLevel: 2)!
        let board = Board(withNumberOfRows: 6, withNumberOfColumns: 7)!
        let result = ai.play(withBoard: board)
        XCTAssertGreaterThanOrEqual(result, 0)
        XCTAssertLessThan(result, board.numberOfColumns)
    }
    
    func testMinMaxAlgorithm() throws {
        func expect(grid: [[Int?]], expectedColumn: Int) {
            let board = Board(withGrid: grid)!
            let ai = MinamaxAI(withId: 2, withName: "Toto", withDifficultyLevel: 3)!
            XCTAssertEqual(expectedColumn, ai.play(withBoard: board))
        }
        
        let testCases: [(grid: [[Int?]], column: Int)] = [
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, nil, nil, nil, nil]],
             column: 3),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 2, 1, 1, nil, 1, 1]],
             column: 4),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, 1, 1, nil, nil, nil, nil]],
             column: 3),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 2, 2, nil, nil, nil, nil],
                    [2, 1, 2, 1, 2, 2, 2],
                    [2, 2, 1, 2, 1, 2, 1],
                    [2, 1, 1, 1, 2, 1, 1]],
             column: 0),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil,   1, nil, nil],
                    [1,     2,   2, nil,   2, nil, nil],
                    [2,     1,   1,   1,   2,   2,   2],
                    [2,     2,   1,   2,   1,   2,   1],
                    [2,     1,   1,   2,   2,   1,   2]],
             column: 3),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, nil, nil, nil, 2, nil, nil],
                    [1, nil, nil, nil, 2, nil, nil],
                    [1,   1,   2, nil, 2, nil, nil]],
             column: 4),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [1, nil, nil, nil, 1, nil, nil],
                    [1, nil, nil, nil, 2, nil, nil],
                    [1, 1, 2, nil, 2, nil, nil]],
             column: 0),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil,  1,    2,   1, nil, nil],
                    [1,    1,   2,    1,   2, nil, nil],
                    [1,    1,   2,    2,   1, nil, nil]],
             column: 3),
            (grid: [[nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, 2, nil, 2, nil, nil, nil],
                    [nil, 1, 2, 2, 1, 1, 2],
                    [1, 2, 2, 1, 2, 1, 2],
                    [1, 1, 2, 2, 1, 1, 1]],
             column: 2),
            ]
        for testCase in testCases {
            expect(grid: testCase.grid, expectedColumn: testCase.column)
        }
        
    }
}
