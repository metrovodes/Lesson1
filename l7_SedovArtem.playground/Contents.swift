import Foundation

enum door: CustomStringConvertible{
    case opened
    case closed
    
    var description: String {
        switch self{
        case .opened:
            return "Дверца открыта"
        case .closed:
            return "Дверца закрыта"
        }
    }
        
}

enum mode: CustomStringConvertible{
    case wash
    case rinsing
    case spin
    case off
    
    var description: String{
        switch self{
        case .wash:
            return "Стирка"
        case .off:
            return "Выключена"
        case .spin:
            return "Отжим"
        case .rinsing:
            return "Полоскание"
        }
    }
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

enum washerStatus:CustomStringConvertible{
    case busy
    case free
    
    var description: String{
        switch self{
        case .busy:
            return "Режим запущен"
        case .free:
            return "Режим не запущен"
        }
    }
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
    
    func load(_ a: Int) throws -> Int{
        guard self.doorStatus == .opened else{
            throw washerErrors.doorClosed
        }
        
        guard self.currentLoad != self.maxLoad else {
            throw washerErrors.maxLoad
        }
        
        switch a + self.currentLoad{
        case self.maxLoad...:
            self.currentLoad = self.maxLoad
        case 0...self.maxLoad:
            self.currentLoad += a
        default:
            self.currentLoad = 0
        }
        return self.currentLoad
    }
}
