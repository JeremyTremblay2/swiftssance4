import XCTest
import Model

final class Coordinate_UT: XCTestCase {
    
    func testDescription() throws {
        let coordinate = Coordinate(atX: 3, atY: 5)
        XCTAssertEqual(coordinate.description, "[3;5]")
    }
    
    func testEquality() throws {
        let coordinate1 = Coordinate(atX: 3, atY: 5)
        let coordinate2 = Coordinate(atX: 3, atY: 5)
        XCTAssertEqual(coordinate1, coordinate2)
    }
    
    func testInequality() throws {
        let coordinate1 = Coordinate(atX: 3, atY: 5)
        let coordinate2 = Coordinate(atX: 5, atY: 3)
        XCTAssertNotEqual(coordinate1, coordinate2)
    }
    
    func testHashValue() throws {
        let coordinate1 = Coordinate(atX: 3, atY: 5)
        let coordinate2 = Coordinate(atX: 3, atY: 5)
        XCTAssertEqual(coordinate1.hashValue, coordinate2.hashValue)
    }
}
