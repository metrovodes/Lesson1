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
    case empty
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
    private var status: washerStatus = .free
    
    init(brand: String, maxLoad: Int){
        self.brand = brand
        self.maxLoad = maxLoad
    }
    
    func doorOpenClose(_ a: door) throws{
        guard self.mode == .off else {
            throw washerErrors.noPower
        }
        
        guard self.status == .free else{
            throw washerErrors.busy
        }
        
        self.doorStatus = a
    }
    
    func changeMode(_ a: mode) throws -> mode{
        guard self.status == .free else{
            throw washerErrors.busy
        }
        
        switch a{
        case .off:
            self.mode = .off
        case .rinsing:
            self.mode = .rinsing
        case .spin:
            self.mode = .spin
        case .wash:
            self.mode = .wash
        }
        
        return a
    }
    
    func startStop() throws{
        switch self.status {
        case .busy:
            self.status = .free
        case .free:
            guard self.mode == .off else{
                throw washerErrors.noPower
            }
            
            guard self.doorStatus == .opened else{
                throw washerErrors.doorOpened
            }
            
            guard self.currentLoad != 0 else{
                throw washerErrors.empty
            }
            
            self.status = .busy
        }
    }
}
