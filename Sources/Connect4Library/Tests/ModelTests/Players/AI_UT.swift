import XCTest
import Model

final class AI_UT: XCTestCase {
    
    func testPlayWithBoard() throws {
        let ai = AI(withId: 1, withName: "AI")
        let board = Board(withNumberOfRows: 6, withNumberOfColumns: 7)
        let result = ai!.play(withBoard: board!)
        XCTAssertTrue(result >= 0 && result < board!.numberOfColumns, "column chosen by AI should be within the range of number of columns")
    }
    
    func testPlayWithFullBoard() throws {
        let ai = AI(withId: 1, withName: "AI")
        var board = Board(withNumberOfRows: 6, withNumberOfColumns: 7)
        for column in 0..<board!.numberOfColumns {
            for _ in 0..<board!.numberOfRows {
                _ = board?.insertPiece(from: ai!.id, atColumn: column)
            }
        }
        let result = ai!.play(withBoard: board!)
        XCTAssertEqual(result, -1, "column chosen by AI should be -1 as the board is full")
    }
}
