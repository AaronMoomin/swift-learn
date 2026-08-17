/**
 存储属性
    将常量和变量值作为实例的一部分进行存储,由类和结构体提供
 计算属性
    由类,结构和枚举提供
 */

// 存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

// 延迟加载存储属性 关键字 lazy
class DataImporter {
    /*
       DataImporter 是一个负责将外部文件中的数据导入的类。
       这个类的初始化会消耗不少时间。
       */
       var filename = "data.txt"
       // 这里会提供数据导入功能
}
class DataManager {
    lazy var importer = DataImporter() // 只有在第一次被访问的时候才被创建
    var data: [String] = []
}
let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
// DataImporter 实例的 importer 属性还没有被创建

// 计算属性 getter setter
struct Point {
    var x = 0.0,y=0.0
}
struct Size {
    var width=0.0,height=0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                              y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// 只读计算属性 省略get关键字和花括号
struct Cuboid {
    var width=0.0,height=0.0,depth=0.0
    // 声明为使用 var 关键字的变量属性，因为它们的值并非固定的
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0,height: 5.0,depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

/**
 属性观察器 willSet(存储之前调用) didSet(存储之后调用)
     可添加位置
     1.自定义的存储属性
     2.继承的存储属性
     3.继承的计算属性
 */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 986

// 属性包装器 @propertyWrapper
/**
 属性包装器在管理属性存储方式的代码和定义属性的代码之间添加了一层分离
 */
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12)}
    }
}
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
var rectangle = SmallRectangle()
print(rectangle.width) // 0
rectangle.height = 10
print(rectangle.height) // 10
rectangle.width = 24
print(rectangle.width) // 12

// 设置被包装属性的初始值
@propertyWrapper
struct SmallNumber {
    private var maximun: Int
    private var number: Int
    var wrappedValue:Int {
        get { return number }
        set { number = min(newValue,maximun) }
    }
    init() {
        maximun = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximun = 12
        number = min(wrappedValue, maximun)
    }
    init(wrappedValue: Int, maximun: Int) {
        self.maximun = maximun
        number = min(wrappedValue, maximun)
    }
}
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width) // 0 0

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width) // 1 1

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximun: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximun: 4) var width: Int
}
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width) // 2 3
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width) // 5 4

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximun: 9) var width: Int = 2 // 相当于 @SmallNumber(wrappedValue: 2, maximun: 9) var width: Int
}
var mixedRectangle = MixedRectangle()
print(mixedRectangle.height) // 1
mixedRectangle.width = 20
print(mixedRectangle.width) // 9

// 从属性包装器中呈现一个值
@propertyWrapper
struct SmallNumber2 {
    private var number: Int
    private(set) var projectedValue: Bool // 判断包装器是否调整 名称为 projectedValue
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init(){
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeSturcture {
    @SmallNumber2 var someNumber: Int
}
var someStructure = SomeSturcture()
someStructure.someNumber = 4
print(someStructure.$someNumber)
someStructure.someNumber = 55
print(someStructure.$someNumber)

enum Size2 {
    case small,large
}
struct SizedRectangle {
    @SmallNumber2 var height: Int
    @SmallNumber2 var width: Int
    
    mutating func resize(to size: Size2) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}
var sizedRectangle = SizedRectangle()
let result = sizedRectangle.resize(to: .large)
print(result)

/**
 类型属性语法 使用static关键字定义
 计算类型属性 使用class关键字 允许子类重写父类
*/
@MainActor
struct SomeStructure2 {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static let storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static let storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
print(SomeStructure2.storedTypeProperty)
// 打印 "Some value."。
SomeStructure2.storedTypeProperty = "Another value."
print(SomeStructure2.storedTypeProperty)
// 打印 "Another value."。
print(SomeEnumeration.computedTypeProperty)
// 打印 "6"。
print(SomeClass.computedTypeProperty)
// 打印 "27"。
