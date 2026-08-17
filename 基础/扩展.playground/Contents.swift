/**
 扩展--用于为现在的类、结构体、枚举或协议类型添加新的功能
 · 添加计算属性 ⚠️不能添加存储属性
 · 定义实例方法和类方法
 · 提供新的构造器
 · 定义下标
 · 定义和使用新的嵌套类型
 · 使已经存在的类型遵循一个协议
 
 ⚠️ 扩展可以给一个类型添加新的功能, 但是不能重写已经存在的功能
 
 语法
 extension SomeType { }
 extension SomeType: SomeProtocol, AnotherProtocol
    
 ⚠️ 对一个现有的类型, 如果你定义了一个扩展来添加新的功能, 那么这个类型的所有实例都可以使用这个新功能,包括那些在扩展定义之前就存在的实例
 */

// 计算属性
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

/**
 构造器
 */
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

// 方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    // 实例方法
    mutating func square() {
        self = self * self
    }
    // 下标
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    // 嵌套类型
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
3.repetitions {
    print("hello")
}
var someInt = 3
someInt.square() // 9
746381295[0] // 5
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
