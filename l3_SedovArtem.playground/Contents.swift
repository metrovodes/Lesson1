import Foundation

enum Engine: String{
    case on = "Двигатель запущен"
    case off = "Двигатель заглушен"
}

enum Windows: String{
    case opened = "Окна открыты"
    case closed = "Окна закрыты"
}

enum Trunk{
    case full(full: String)
    case empty(empty: String)
    case partly(kg: Int)
}

struct SportCar{
    let manufacturer: String
    let year: Int
    let volume: Int
    var volumed: Int = 0
    var engineStatus: Engine = .off
    var windowsStatus: Windows = .closed
    
    init(manufacturer: String, year: Int, volume: Int){
        self.manufacturer = manufacturer
        self.year = year
        self.volume = volume
    }
    
    mutating func changeEngine(action: Engine){
        switch action{
        case .on:
            self.engineStatus = .on
        case .off:
            self.engineStatus = .off
        }
    }
    
    mutating func moveWindows(action: Windows){
        switch action{
        case .closed:
            self.windowsStatus = .closed
        case .opened:
            self.windowsStatus = .opened
        }
        print(self.windowsStatus.rawValue)
    }
    
    mutating func load(volume: Int){
        switch volume + self.volumed{
        case ...0:
            self.volumed = 0
        case 0...self.volume:
            self.volumed += volume
        default:
            self.volumed = self.volume
        }
    }
    
    func printDetails(){
        print("Автомобиль \(self.manufacturer) произведен в \(self.year) году. \(self.engineStatus.rawValue). \(self.windowsStatus.rawValue). Объем багажника \(self.volume) кг, заполнено \(self.volumed) кг.")
    }
}


struct TrunckCar{
    let manufacturer: String
    let year: Int
    let trunkVolume: Int
    var trunkVolumed: Int = 0
    var engineStatus: Engine = .off
    var windowStatus: Windows = .closed
    
    init(brand: String, year: Int, trunkVolume: Int){
        self.manufacturer = brand
        self.year = year
        self.trunkVolume = trunkVolume
    }
    
    func printDetails(){
        print("Грузовик \(self.manufacturer) произведен в \(self.year) году. \(self.engineStatus.rawValue). \(self.windowStatus.rawValue). Объем багажника \(self.trunkVolume) кг, заполнено \(self.trunkVolumed) кг.")
    }
    
    mutating func changeEngine(action: Engine){
        switch action {
        case .off:
            self.engineStatus = .off
        case .on:
            self.engineStatus = .on
        }
        print(self.engineStatus.rawValue)
    }
    
    mutating func changeWindows(action: Windows){
        switch action {
        case .closed:
            self.windowStatus = .closed
        case .opened:
            self.windowStatus = .opened
        }
        print(self.windowStatus.rawValue)
    }
    
    mutating func load(volume: Int){
        switch volume + self.trunkVolumed{
        case ...0:
            self.trunkVolumed = 0
        case 0...self.trunkVolume:
            self.trunkVolumed += volume
        default:
            self.trunkVolumed = self.trunkVolume
        }
        print("Загружено \(self.trunkVolumed) кг в \(self.manufacturer)")
    }
}

var skoda = SportCar(manufacturer: "Skoda", year: 2018, volume: 400)
var audi = SportCar(manufacturer: "Audi", year: 2009, volume: 320)


skoda.printDetails()
skoda.changeEngine(action: .off)
skoda.moveWindows(action: .opened)
skoda.load(volume: 220)
skoda.printDetails()
skoda.load(volume: 220)
skoda.printDetails()
skoda.load(volume: -500)
skoda.printDetails()

audi.changeEngine(action: .on)
audi.moveWindows(action: .opened)
audi.printDetails()
audi.moveWindows(action: .closed)

var scania = TrunckCar(brand: "Scania", year: 2008, trunkVolume: 10000)
var man = TrunckCar(brand: "MAN", year: 2022, trunkVolume: 15000)

scania.printDetails()
scania.load(volume: 1500)
scania.printDetails()
scania.changeEngine(action: .on)
scania.printDetails()
scania.load(volume: -300)
scania.changeWindows(action: .opened)
scania.printDetails()

man.changeEngine(action: .on)
man.changeWindows(action: .opened)
man.printDetails()

