public class Human : Player {
    private let scanner: () -> Int
    
    public init?(withId id: Int, withName name: String, andScanner scanner: @escaping () -> Int) {
        self.scanner = scanner
        super.init(withId: id, withName: name)
        
    }
    public override func play(withBoard board: Board) -> Int {
        return scanner()
    }
}
