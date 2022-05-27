import Foundation

// Задание № 1. Проверяем, является ли число четным

func isEven(number n: Int) -> Bool {
    let res: Bool
    if n % 2 == 0 {
        res = true
    }else {
        res = false
    }
    return res
}

// Задание № 2. Проверяем, делится ли число на 3 без остатка
func divideThree(number n : Int) -> Bool {
    let res: Bool
    if n % 3 == 0 {
        res = true
    }else {
        res = false
    }
    return res
}

// Задание № 3. Создание массива  возрастающих чисел, состоящего из 100 элементов

var numbers: [Int] = Array(1...100)

// Задание № 4. Отфильтровать массив с помощью функций из заданий 1 и 2.

func checkElements (arrayToCheck a: [Int]) -> Array<Int> {
    var newNumbers: [Int] = []
    for i in a {
        if isEven(number: i) && !divideThree(number: i) {
            newNumbers.append(i)
        }
    }
    return newNumbers
}

