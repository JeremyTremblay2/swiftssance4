public enum BoardResult {
    case unknow
    case ok
    case failed(FailedReason)
}

public enum FailedReason {
    case outOfBounds
    case columnFull
    case invalidPlayerId
    case emptyColumn
    case pieceAlreadyPresentAbove
}
