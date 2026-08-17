/**
 比较结构体struct和类class
    
 共同点
        1. 定义属性来存储值
        2 .定义方法来提供功能
        3. 定义下标来使用下标语法访问其值
        4. 定义构造器来设置初始化状态
        5. 被扩展以增加默认实现方法之外的功能
        6. 遵循协议以提供某种标准功能
 
 类的额外功能
        1.一个类允许继承另一个类
        2. 类型转换允许在运行时检查和解释类实例的类型
        3. 析构器允许一个类的实例释放其分配的任何资源
        4.引用计数允许对类实例的多个引用
 
 类支持的额外功能以增加其复杂性为代价。 作为一般准则，我们会优先使用结构体， 因为它们更易于理解，并在适当或必要时使用类。 在实践中，这意味着你定义的大多数自定义类型将是结构体和枚举
 */
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String? // 可选值 默认为 nil
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

// 结构体逐一语法构造器
// 与结构体不同，类实例没有默认的逐一成员构造器
let vga = Resolution(width: 640, height: 480)
// 值类型 赋值会创建新的副本 (深复制)
var cinema = vga
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("vga is still \(vga.width) pixels wide")

enum CompassPoint {
    case north, east, south, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()
print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

// 类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = vga
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
