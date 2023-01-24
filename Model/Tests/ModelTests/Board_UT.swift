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
}
