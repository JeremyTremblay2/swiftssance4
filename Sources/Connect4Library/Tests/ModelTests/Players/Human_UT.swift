import XCTest
import Model

final class Human_UT: XCTestCase {
    
    func testHumanInitializationSuccess() throws {
        let human = Human(withId: 1, withName: "John Doe", andScanner: { return 0 })
        XCTAssertNotNil(human)
    }
    
    func testHumanInitializationFailure() throws {
        let human = Human(withId: 0, withName: "", andScanner: { return 0 })
        XCTAssertNil(human)
    }
    
    func testHumanDescription() throws {
        let human = Human(withId: 1, withName: "John Doe", andScanner: { return 0 })!
        XCTAssertEqual(human.description, "[1] John Doe")
    }
    
    func testHumanPlay() throws {
        let human = Human(withId: 1, withName: "John Doe", andScanner: { return 0 })!
        let board = Board()
        let result = human.play(withBoard: board!)
        XCTAssertEqual(result, 0)
    }
}
