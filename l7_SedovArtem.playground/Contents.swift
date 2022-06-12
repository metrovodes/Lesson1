import Foundation

enum door{
    case opened
    case closed
}

enum mode{
    case wash
    case rinsing
    case spin
    case off
}

enum washerErrors: Error{
    case noPower
    case doorClosed
    case doorOpened
    case maxLoad
    case wrongMode
    case busy
}

enum washerStatus{
    case busy
    case free
}

class Washer{
    let brand: String
    let maxLoad: Int
    var currentLoad: Int = 0
    var doorStatus: door = .closed
    var mode: mode = .off
    var status: washerStatus = .free
    
    init(brand: String, maxLoad: Int){
        self.brand = brand
        self.maxLoad = maxLoad
    }
    
    func doorOpenClose(_ a: door) throws{
        guard self.mode == .off else {
            throw washerErrors.noPower
        }
        
        guard self.status == .free{
            throw washerErrors.busy
        }
        
        self.doorStatus = a
    }
}
