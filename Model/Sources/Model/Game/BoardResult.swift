public enum BoardResult : Equatable {
    case unknow
    case ok
    case failed(FailedReason)
    
    public static func == (lhs: BoardResult, rhs: BoardResult) -> Bool {
       switch (lhs, rhs) {
       case (.unknow, .unknow), (.ok, .ok):
           return true
       case let (.failed(lhsReason), .failed(rhsReason)):
           return lhsReason == rhsReason
       default:
           return false
       }
   }
}

public enum FailedReason : Equatable {
    case outOfBounds
    case columnFull
    case invalidPlayerId
    case columnEmpty
    
    public static func == (lhs: FailedReason, rhs: FailedReason) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
