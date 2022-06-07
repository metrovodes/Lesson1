import Foundation

enum Engine: CustomStringConvertible{
     case on
     case off
    
    var description: String {
        switch self {
        case .off: return "Двигатель выключен"
        case .on: return "Двигатель включен"
        }
    }
 }

 enum Windows: CustomStringConvertible{
     case opened
     case closed
     
     var description: String {
         switch self {
         case .opened: return "Окна открыты"
         case .closed: return "Окна закрыты"
         }
     }
 }

enum Trunk: CustomStringConvertible{
    case opened
    case closed
    
    var description: String{
        switch self{
        case .opened: return "Багажник открыт"
        case .closed: return "Багажник закрыт"
        }
    }
    
}

enum Trailer: String{
    case tank = "Цистерна"
    case refrigerator = "Рефрижератор"
    case cargo = "Прицеп"
}

enum Action{
    case windowsOpenClose
    case engineOnOff
    case trunkLoad(Int)
    case trunkOpenClose
    case trailerAttach(Trailer?, Int?)
}

class Car{
    let brand: String
    let year: Int
    var windowStatus: Windows = .closed
    var engineStatus: Engine = .off
    
    init(brand: String, year: Int){
        self.brand = brand
        self.year = year
    }
    
    func modify (_ a: Action) -> Void {
    }
}

class SportCar: Car, CustomStringConvertible{
    let trunkVolume: Int?
    var volumed: Int = 0
    var trunkStatus: Trunk?
    
    init(brand: String, year: Int, trunkVolume tv: Int? = nil, trunkStatus ts: Trunk? = nil){
        
        if ts != nil {
            self.trunkVolume = tv
            self.trunkStatus = ts
        }else {
            trunkStatus = nil
            trunkVolume = nil
        }
        
        super.init(brand: brand, year: year)
    }
    
    var description: String{
        let b: String
        
        switch self.trunkStatus{
        case .closed:
            b = "\(self.trunkStatus!)(для загрузки необходимо открыть багажник), загружено \(self.volumed) из \(self.trunkVolume!) кг."
        case .opened:
            if volumed != self.trunkVolume && volumed != 0 {
                b = "\(self.trunkStatus!), загружено \(volumed) кг. Возможно дополнительно загрузить \(self.trunkVolume! - volumed) кг."
            } else if volumed == 0{
                b = "\(self.trunkStatus!), пустой. Можно загрузить \(self.trunkVolume!) кг"
            }else {
                b = "\(self.trunkStatus!), загружен полностью \(self.trunkVolume!) кг"
            }
        default:
            b  = "Багажник отсутствует"
        }
        
        return "Спорткар \(self.brand) выпущен в \(self.year).\n\(self.engineStatus)\n\(self.windowStatus)\n\(b)\n______"
    }
    
    override func modify(_ a: Action) {
        switch a{
        case .engineOnOff:
            
            switch self.engineStatus{
            case .on:
                self.engineStatus = .off
            case .off:
                self.engineStatus = .on
            }
            
        case .windowsOpenClose:
            
            switch self.windowStatus{
            case .opened:
                self.windowStatus = .closed
            case .closed:
                self.windowStatus = .opened
            }
            
        case .trunkLoad(let load):
            
            if self.trunkStatus != nil {
                
                switch self.volumed + load{
                case self.trunkVolume!... where self.trunkStatus == .opened:
                    self.volumed = self.trunkVolume!
                case 0...self.trunkVolume! where self.trunkStatus == .opened:
                    self.volumed += load
                case ...0 where self.trunkStatus == .opened:
                    self.volumed = 0
                default:
                    print("Ошибка, багажник закрыт. Для загрузки необходимо открыть багажник.")
                }
                
                if self.trunkStatus == .opened{
                    print("Загрузка завершена")
                }
                
            }else {
                print("Ошибка! Багажник отсутствует")
            }
            
        case .trunkOpenClose:
            
            switch self.trunkStatus{
            case .closed:
                self.trunkStatus = .opened
            case .opened:
                self.trunkStatus = .closed
            default:
                print("Ошибка! Багажник отсутствует")
            }
            
        default: break
        }
    }
}

class TrunckCar: Car, CustomStringConvertible {
    var trailer: Trailer?
    var loaded: Int = 0
    var maxTrailerLoad: Int?
    
    var description: String{
        let tDesc: String
        if self.trailer != nil && self.maxTrailerLoad != nil{
            tDesc = "Трейлер прикреплен (\(self.trailer!.rawValue), грузоподъемность \(self.maxTrailerLoad!) кг). Загружено \(self.loaded) кг."
        }else{
            tDesc = "Трейлер не прикреплен"
        }
        return "Грузовик \(self.brand) произведен в \(self.year) году.\n\(self.engineStatus)\n\(self.windowStatus)\n\(tDesc)\n "
    }
    
    init(brand: String, year: Int, trailer: Trailer? = nil, trailerMaxLoad: Int? = nil){
        if trailer != nil && trailerMaxLoad != nil{
            self.trailer = trailer
            self.maxTrailerLoad = trailerMaxLoad
        }else {
            self.trailer = nil
            self.maxTrailerLoad = nil
        }
        
        super.init(brand: brand, year: year)
    }
    
    override func modify(_ a: Action) {
        switch a {
        case .trailerAttach(let t, let maxLoad):
            self.loaded = 0
            
            if t != nil{
                self.trailer = t
            }else {
                self.trailer = nil
            }
            
            if maxLoad != nil{
                self.maxTrailerLoad = maxLoad
            }else{
                self.maxTrailerLoad = nil
            }
            
        case .trunkLoad(let load):
            if self.trailer != nil {
                switch load + self.loaded {
                case self.maxTrailerLoad!...:
                    self.loaded = self.maxTrailerLoad ?? 0
                case 0...self.maxTrailerLoad!:
                    self.loaded += load
                default:
                    self.loaded = 0
                }
            }else {
                print("Загрузить невозможно, отсутствует Trailer")
            }
        case .engineOnOff:
            
            switch self.engineStatus{
            case .on:
                self.engineStatus = .off
            case .off:
                self.engineStatus = .on
            }
            
        case .windowsOpenClose:
            
            switch self.windowStatus{
            case .opened:
                self.windowStatus = .closed
            case .closed:
                self.windowStatus = .opened
            }
        default: break
        }
    }
}

var honda = SportCar(brand: "Honda", year: 2008, trunkVolume: 500, trunkStatus: .closed)
var koenigsegg = SportCar(brand: "koenigsegg", year: 2022)

honda.modify(.engineOnOff)
honda.modify(.trunkOpenClose)
honda.modify(.trunkLoad(200))
honda.modify(.trunkOpenClose)
print(honda)

koenigsegg.modify(.trunkOpenClose)
koenigsegg.modify(.trunkLoad(500))
koenigsegg.modify(.windowsOpenClose)
print(koenigsegg)




var scania = TrunckCar(brand: "Scania", year: 2008)
var kamaz = TrunckCar(brand: "Kamaz", year: 1996, trailer: .cargo, trailerMaxLoad: 1400)

scania.modify(.trailerAttach(.refrigerator, 5000))
scania.modify(.trunkLoad(4700))
print(scania)
scania.modify(.trailerAttach(nil, nil))
print(scania)


kamaz.modify(.trunkLoad(300))
print(kamaz)
kamaz.modify(.trailerAttach(.tank, 4000))
kamaz.modify(.trunkLoad(4000))
kamaz.modify(.trunkLoad(-123))
print(kamaz)
kamaz.modify(.trailerAttach(nil, nil))
print(kamaz)
