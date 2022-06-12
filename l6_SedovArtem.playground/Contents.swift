import Foundation

struct queue<Element: Comparable> {
    
    var elements = [Element]()
    
    mutating func add(_ elem: Element){
        elements.append(elem)
    }
    
    mutating func remove() -> Element?{
        if(elements.count != 0){
            return elements.removeFirst()
        }else{
            self.isEmpty()
            return nil
        }
    }
    
    func printQuantity(){
        print(elements.count)
    }
    
    
    func isEmpty(){
        elements.count != 0 ? print("Очередь: \(elements)") : print("Очередь пуста")
    }
    
    mutating func clear(){
        elements = []
    }
    
    
    subscript(_ i: Int) -> Element?{
        i < elements.count ? elements[i] :  nil
    }
}

var integers = queue<Int>()

integers.isEmpty()

integers.add(5)
integers.add(3)
integers.printQuantity()

integers.remove()

integers.isEmpty()

integers.add(3)
integers.clear()

integers[1]
integers[10]

integers.isEmpty()
