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
