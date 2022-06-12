import Foundation

enum door{
    case opened
    case closed
}

enum mode{
    case wash
    case free
    case rinsing
    case spin
    case off
}

enum stiralkaErrors: Error{
    case noPower
    case doorClosed
    case doorOpened
    case maxLoad
    case wrongMode
}

class Stiralka{
    let brand: String
    let maxLoad: Int
    var currentLoad: Int = 0
    var doorStatus: door = .closed
    var mode: mode = .off
    
    init(brand: String, maxLoad: Int){
        self.brand = brand
        self.maxLoad = maxLoad
    }
    
}
