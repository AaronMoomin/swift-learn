// 最简单的泛型
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

// 泛型结构体
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

/**
 类型约束语法
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
     // function body goes here
 }
 */
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

// 不是所有的 Swift 类型都可以用等式符（==）进行比较, 从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议
func findIndexWithT<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
if let doubleIndex = findIndexWithT(of: 9.3, in: [3.14159, 0.1, 0.25]) {
    print("The index of 9.3 is \(doubleIndex)")
} else {
    print("can not find 9.3")
}
if let stringIndex = findIndexWithT(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"]) {
    print("The index of Andrea is \(stringIndex)")
} else {
    print("can not find Andrea")
}
 
// 关联类型 associatedtype
// 协议不能直接存储泛型类型 eg: ❌ protocol Container<T>{}
protocol Container {
    // ✅ 正确写法 associatedtype
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
struct IntStack: Container {
    // IntStack 原始实现
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container 协议的实现部分 typealias
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

// 多协议约束
func test<T: Equatable & Hashable>(_ value: T) { }

// 泛型where
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

// 包含上下文关系的where
extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count - 1] == item
    }
}
extension Array: Container {}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
print(numbers.endsWith(37))

// 泛型下标
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

