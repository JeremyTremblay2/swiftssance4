import XCTest
import Model

final class Player_UT: XCTestCase {

    func testInitWithIdAndName() throws {
        let player = Player(withId: 1, withName: "John")
        
        XCTAssertNotNil(player)
        XCTAssertEqual(player?.id, 1)
        XCTAssertEqual(player?.name, "John")
    }
    
    func testInitWithInvalidId() throws {
        let player = Player(withId: -1, withName: "John")
        
        XCTAssertNil(player)
    }
    
    func testInitWithEmptyName() throws {
        let player = Player(withId: 1, withName: "")
        
        XCTAssertNil(player)
    }
    
    func testDescription() throws {
        let player = Player(withId: 1, withName: "John")!
        
        XCTAssertEqual(player.description, "[1] John")
    }
    
    func testPlayWithBoard() throws {
        let player = Player(withId: 1, withName: "John")!
        let board = Board()
        
        XCTAssertEqual(player.play(withBoard: board!), 0)
    }
}
