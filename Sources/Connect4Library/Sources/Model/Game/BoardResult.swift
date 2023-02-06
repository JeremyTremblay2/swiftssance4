/// The `BoardResult` enum represents the result of an operation performed on the `Board` class.
///
/// - unknow: The operation was not completed or its result is unknown.
/// - ok: The operation was successful.
/// - failed: The operation faild with a reason indicated by a `FailedReason` case.
public enum BoardResult: Equatable {
    case unknow
    case ok
    case failed(FailedReason)
    
    /// Returns a Boolean value indicating whether two `BoardResult` values are equal.
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

/// The `FailedReason` enum represents the reason why an operation performed on the `Board` class failed.
///
/// - outOfBounds: The operation was outside the bounds of the board.
/// - columnFull: The operation was peformed on a full column.
/// - invalidPlayerId: The operation was performed with an invalid player id.
/// - columnEmpty: The operation was performed on an empty column.
public enum FailedReason: Equatable {
    case outOfBounds
    case columnFull
    case invalidPlayerId
    case columnEmpty
    
    /// Returns a Boolean value indicating whether two `FailedReason` values are equal.
    public static func == (lhs: FailedReason, rhs: FailedReason) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
