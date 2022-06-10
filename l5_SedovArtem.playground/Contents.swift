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

protocol SportCar: Car{
    var topSpeed: Int { get }
    var currentSpeed: Int { get set }
}

extension SportCar{
    mutating func accelerate (speed s: Int){
        switch self.currentSpeed + s{
        case topSpeed...:
            self.currentSpeed = self.topSpeed
            print("Достигнута максимальная скорость")
        case 0...topSpeed:
            self.currentSpeed += s
            print("Текущая скорость - \(self.currentSpeed) км/ч")
        default:
            self.currentSpeed = 0
            print("Остановились")
        }
    }
}

protocol TrunkCar: Car{
    var trailerMaxLoad: Int { get set }
    var currentLoad: Int { get set }
}

extension TrunkCar{
    mutating func loadTrailer (weight w: Int){
        switch self.currentLoad + w{
        case self.trailerMaxLoad...:
            self.currentLoad = self.trailerMaxLoad
        case 0...self.currentLoad:
            self.currentLoad += w
        default:
            self.currentLoad = 0
        }
    }
}
