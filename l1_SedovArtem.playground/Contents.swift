import Foundation

// Задание № 1. Решение квадратного уравнения

let a: Double = 2
let b: Double = 100
let c: Double = 45

let D: Double = b * b - 4 * a * c


if D < 0 {
    
    print("Решений уравнения нет")
    
}else {
    
    if D == 0{
        
        let x = (b * (-1) - D) / (2 * a) + 0
        print("x = \(x)")
        
    }else {
        
        let x1 = (b * (-1) - sqrt(D) ) / (2 * a)
        let x2 = (b * (-1) + sqrt(D) ) / (2 * a)
        print("x1 = \(x1)\nx2 = \(x2)")
        
    }
}

// Задание № 2. Поиск параметров треугольника (площадь, периметр и гипотенузу) по данным катетам

let cathet1: Double = 4.2
let cathet2: Double = 3.6

let hypotenuse: Double = sqrt(cathet1 * cathet1 + cathet2 * cathet2) //Находим гипотенузу

let square: Double = cathet1 * cathet2 / 2 // Находим площадь

let perimeter: Double = cathet1 + cathet2 + hypotenuse // Находим периметр

print("\nКатеты треугольника равны \(String(format: "%.2f", cathet1)) см и \(String(format: "%.2f", cathet2)) см.\nГипотенуза равна \(String(format: "%.2f", hypotenuse)) см.\nПлощадь треугольника равна \(String(format: "%.2f", square)) см2.\nПериметр треугольника равен \(String(format: "%.2f", perimeter)) ")
