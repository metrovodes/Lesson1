import Foundation

enum engineStatus{
    case on
    case off
}

enum windowsStatus{
    case opened
    case closed
}
protocol Car{
    var brand: String { get }
    var year: Int { get }
    var windows: windowsStatus { get set }
    var engine: engineStatus { get set }
}
