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
        case ...self.currentLoad:
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
        let es: String
        switch self.engine {
        case .off:
            es = "Двигатель выключен."
        case .on:
            es = "Двигатель запущен."
        }
        let ws: String
        switch self.windows{
        case .closed:
            ws = "Окна закрыты."
        case .opened:
            ws = "Окна открыты."
        }
        return "Грузовик \(self.brand). \(self.year) года выпуска.\n\(es) \(ws)\nТекущая загрузка кузова: \(self.currentLoad) из \(self.trailerMaxLoad) кг."
    }
}

var man = trunkCar(name: "Man", releaseYear: 2006, trailerMLoad: 500)

man.loadTrailer(weight: 222)
man.windowsOpenClose(.opened)
man.engineOnOff(.on)

print(man)
