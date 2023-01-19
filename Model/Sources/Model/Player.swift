public class Player {
    let id: Int
    let name: String
    
    public init?(withId id: Int, withName name: String) {
        guard id > 0 && !name.isEmpty else {
            return nil
        }
        self.id = id
        self.name = name
    }
}
