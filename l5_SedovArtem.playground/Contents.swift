import Foundation

enum engineStatus: CustomStringConvertible{
    case on
    case off
    
    var description: String{
        switch self{
        case .on:
            return "Двигатель запущен."
        case.off:
            return "Двигатель выключен."
        }
    }
}

enum windowsStatus: CustomStringConvertible{
    case opened
    case closed
    
    var description: String{
        switch self{
        case .opened:
            return "Окна открыты."
        case .closed:
            return "Окна закрыты."
        }
    }
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
        case ...0:
            self.currentLoad = 0
        default:
            self.currentLoad += w
        }
    }
}

class trunkCar: TrunkCar{
    var brand: String
    var year: Int
    var windows: windowsStatus = .closed
    var engine: engineStatus = .off
    var trailerMaxLoad: Int
    var currentLoad: Int = 0
    
    init(name: String, releaseYear: Int, trailerMLoad: Int){
        self.brand = name
        self.year = releaseYear
        self.trailerMaxLoad = trailerMLoad
    }
}

extension trunkCar: CustomStringConvertible{
    var description: String{
        return "Грузовик \(self.brand). \(self.year) года выпуска.\n\(self.engine) \(self.windows)\nТекущая загрузка кузова: \(self.currentLoad) из \(self.trailerMaxLoad) кг.\n"
    }
}

class sportCar: SportCar{
    var brand: String
    var year: Int
    var windows: windowsStatus = .closed
    var engine: engineStatus = .off
    var currentSpeed: Int = 0
    var topSpeed: Int
    init(name: String, releaseYear: Int, maxSpeed: Int){
        self.brand = name
        self.year = releaseYear
        self.topSpeed = maxSpeed
    }
}

extension sportCar: CustomStringConvertible{
    var description: String{
        return "Спорткар \(self.brand), произведен в \(self.year) году.\n\(self.engine) \(self.windows)\nТекущая скорость - \(self.currentSpeed) км/ч.\n Максимальная скорость - \(self.topSpeed)км/ч\n"
    }
}

var honda = sportCar(name: "Honda Civic", releaseYear: 2014, maxSpeed: 210)

honda.engineOnOff(.on)
honda.accelerate(speed: 100)
print(honda)

var lexus = sportCar(name: "Lexus ES", releaseYear: 2018, maxSpeed: 276)

lexus.engineOnOff(.on)
lexus.windowsOpenClose(.opened)
lexus.accelerate(speed: 230)

print(lexus)

var kamaz = trunkCar(name: "KAMAZ", releaseYear: 2005, trailerMLoad: 15000)

kamaz.engineOnOff(.on)
kamaz.windowsOpenClose(.opened)
kamaz.loadTrailer(weight: 14780)
kamaz.windowsOpenClose(.closed)

print(kamaz)

var man = trunkCar(name: "MAN", releaseYear: 2015, trailerMLoad: 40000)

man.engineOnOff(.on)
man.loadTrailer(weight: 30000)
man.windowsOpenClose(.opened)
man.loadTrailer(weight: -1000)

print(man)
