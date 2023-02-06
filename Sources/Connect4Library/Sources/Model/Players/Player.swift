public class Player : CustomStringConvertible {
    let id: Int
    let name: String
    
    public var description: String {
        return "[\(id)] \(name)"
    }
    
    public init?(withId id: Int, withName name: String) {
        guard id > 0 && !name.isEmpty else {
            return nil
        }
        self.id = id
        self.name = name
    }
    
    public func play(withBoard board: Board) -> Int {
        return 0
    }
}
