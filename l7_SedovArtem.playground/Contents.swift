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

enum washerPower: CustomStringConvertible{
    case on
    case off
    
    var description: String{
        switch self{
        case .off:
            return "Машинка выключена"
        case .on:
            return "Машинка включена"
        }
    }
}

enum washerMode: CustomStringConvertible{
    case wash
    case rinsing
    case spin
    
    var description: String{
        switch self{
        case .wash:
            return "Стирка"
        case .spin:
            return "Отжим"
        case .rinsing:
            return "Полоскание"
        }
    }
}

enum washerErrors: Error, CustomStringConvertible{
    case noPower
    case doorClosed
    case doorOpened
    case maxLoad
    case busy
    case empty
    
    var description: String{
        switch self{
        case .noPower:
            return "\nОшибка!\nНеобходимо включить машинку"
        case .doorOpened:
            return "\nОшибка!\nНеобходимо закрыть дверцу"
        case .doorClosed:
            return "\nОшибка!\nНеобходимо открыть дверцу"
        case .maxLoad:
            return "\nОшибка!\nМашинка уже загружена полностью"
        case .busy:
            return "\nОшибка!\nМашинка занята, необходимо выключить режим"
        case .empty:
            return "\nОшибка!\nМашинка пустая, невозможно включить режим"
        }
    }
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

class Washer: CustomStringConvertible{
    let brand: String
    let maxLoad: Int
    var currentLoad: Int = 0
    var doorStatus: door = .closed
    var mode: washerMode?
    var status: washerStatus = .free
    private var power: washerPower = .off
    
    init(brand: String, maxLoad: Int){
        self.brand = brand
        self.maxLoad = maxLoad
    }
    
    func doorOpenClose(_ a: door) throws{
        guard self.power != .off else {
            throw washerErrors.noPower
        }
        
        guard self.status == .free else{
            throw washerErrors.busy
        }
        self.doorStatus = a
        print(a)
    }
    
    func changeMode(_ a: washerMode) throws -> washerMode{
        guard self.status == .free else{
            throw washerErrors.busy
        }
        
        guard self.power == .on else{
            throw washerErrors.noPower
        }
        
        switch a{
        case .rinsing:
            self.mode = .rinsing
        case .spin:
            self.mode = .spin
        case .wash:
            self.mode = .wash
        }
        print(self.mode!)
        return a
    }
    
    func startStop() throws{
        switch self.status {
        case .busy:
            self.status = .free
            self.doorStatus = .opened
        case .free:
            guard self.power == .on else{
                throw washerErrors.noPower
            }
            guard self.doorStatus != .opened else{
                throw washerErrors.doorOpened
            }
            
            guard self.currentLoad != 0 else{
                throw washerErrors.empty
            }
            
            self.status = .busy
        }
        print(self.status)
    }
    
    func onOff() throws{
        switch self.power{
        case .on:
            guard self.status != .busy else{
                throw washerErrors.busy
            }
            self.mode = nil
            self.power = .off
        case .off:
            self.power = .on
            self.mode = .wash
        }
        print(self.power)
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
        
        if a > 0{
            print("В машинку загружено \(a) кг\n")
        }else {
            print("Из машинки вытащили \(a) кг\n")
        }
        return self.currentLoad
    }
    
    
    var description: String{
        let status: String
        if self.power == .off{
            status = "Машинка выключена\n"
        }else {
            if self.mode != nil{
                status = "Машинка включена. Режим: \(self.mode!). \(self.status)\n"
            }else {
                status = "Машинка включена. Режим: #undefined#\n"
            }
        }
        
        return "\nМашинка \(self.brand).\nМаксимальная загрузка - \(self.maxLoad).\nТекущая загрузка - \(self.currentLoad).\n_______\n\(status)\(self.doorStatus)\n"
    }
    
}

func washerOnOff(_ w: Washer) throws {
    do {
        try w.onOff()
    } catch washerErrors.busy{
        print(washerErrors.busy)
    }
}

func washerDoorOpenClose(_ w: Washer, action: door) throws {
    do {
        try w.doorOpenClose(action)
    } catch washerErrors.busy {
        print(washerErrors.busy)
    } catch washerErrors.noPower{
        print(washerErrors.noPower)
    }
}

func washerChangeMode(_ w: Washer, mode: washerMode) throws{
    do {
        try w.changeMode(mode)
    } catch washerErrors.busy {
        print(washerErrors.busy)
    } catch washerErrors.noPower {
        print(washerErrors.noPower)
    }

}

func washerStartStop(_ w: Washer) throws{
    do{
        try w.startStop()
    } catch washerErrors.noPower {
        print(washerErrors.noPower)
    } catch washerErrors.doorOpened {
        print(washerErrors.doorOpened)
    } catch washerErrors.empty {
        print(washerErrors.empty)
    }
}

func washerLoad(_ w: Washer, load: Int) throws{
    do {
        try w.load(load)
    } catch washerErrors.doorClosed {
        print(washerErrors.doorClosed)
    } catch washerErrors.maxLoad {
        print(washerErrors.maxLoad)
    }
}

var samsung = Washer(brand: "Samsung", maxLoad: 12)

try washerOnOff(samsung)

try washerChangeMode(samsung, mode: .rinsing)

try washerDoorOpenClose(samsung, action: .opened)

try washerLoad(samsung, load: 2)

try washerDoorOpenClose(samsung, action: .closed)

try washerStartStop(samsung)

try washerDoorOpenClose(samsung, action: .opened)

print(samsung)
