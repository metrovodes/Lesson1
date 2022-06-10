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

extension Car {
    mutating func windowsOpenClose (_ w: windowsStatus){
        switch w{
        case .closed:
            self.windows = .closed
        case .opened:
            self.windows = .opened
        }
    }
    
    mutating func engineOnOff (_ e: engineStatus){
        switch e{
        case .off:
            self.engine = .off
        case .on:
            self.engine = .on
        }
    }
}
