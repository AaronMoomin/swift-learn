/*
 构造过程是使用类、结构体或枚举等实例之前的准备过程。这个过程包括为该实例的每个存储属性设置初始值，并执行任何其他必要的设置或构造过程，以确保新实例在使用前已经完成正确的构造。
 */

// 构造器 init() { }
struct Fahrenheit {
//    var temperature: Double
    // 默认属性值
    var temperature = 32.0
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

struct Celsius {
    var temperatureInCelsius: Double
   init(fromFahrenheit fahrenheit: Double) {
       temperatureInCelsius = (fahrenheit - 32.0) / 1.8
   }
   init(fromKelvin kelvin: Double) {
       temperatureInCelsius = kelvin - 273.15
   }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

/**
 形参命名和实参标签
 
 构造器在括号前没有像函数和方法那样的可辨别的方法名。因此，构造器的形参名称和类型在确定应调用哪个构造器时起着至关重要的作用。正因为如此，如果你没有提供实参标签，Swift会为构造器的每个形参自动提供一个实参标签。
 */
struct Color {
    let red, green, blue:Double
    // 如果构造器定义了某个实参标签，就必须使用它，忽略它将导致编译期错误
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double){
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// 不带实参标签的构造器形参
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)

// 可选属性类型
class SurveyQuestion {
    var text: String
    var response: String? // nil
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

/**
 构造过程中产量属性的赋值
 
 对于类的实例来说，它的常量属性只能在类的构造过程中修改，不能在子类中修改。
 */
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        // 你可以在构造过程中的任意时间点给常量属性赋值，只要在构造过程结束时将它设置成确定的值。一旦常量属性被赋值，它将永远不可更改。
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"

/**
 默认构造器
 
 如果结构体或类为所有属性提供了默认值，又没有提供任何自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为它们默认值的实例。
 */
class ShoppingListItem_default {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem_default()

/**
 结构体类型的成员逐一构造器
 
 Size 结构体会自动获得一个 init(width:height:) 逐一成员构造器，你可以用它来构造一个新的 Size 实例
 */
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
// 可以省略任何具有默认值的属性
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)

/**
 值类型的构造器代理
 
 构造器可以调用其他构造器来完成实例的部分构造过程 避免了重复代码
 */
struct Point {
    var x = 0.0, y = 0.0
}
/**
 使用3种方式来为Rect创建实例
 1.使用含有默认值origin和size属性来初始化
 2.提供指定的origin和size实例来初始化
 3.提供指定的center和size来初始化
 */
struct Rect {
    var origin = Point()
    var size = Size()
    init() { }
    init(origin: Point,size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point,size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX,y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

/**
 指定构造器和便利构造器
 
 指定构造器:
 init(<#parameters#>) {
    <#statements#>
 }
 是类中最重要的构造器,一个指定构造器将初始化类中提供的所有属性,并调用合适的父类构造器让构造过程沿父类链继续往上进行
 
 类倾向于拥有极少的指定构造器,普遍是一个类只拥有一个指定构造器
 
 每个类都必须至少拥有一个指定构造器
 
 便利构造器:
 convenience init(<#parameters#>) {
    <#statements#>
 }
 是类中比较次要的,辅助型的构造器,应当只在必要的时候为类提供便利构造器
 */

/**
 类类型的构造器代理
 为了简化指定构造器和便利构造器之间的调用关系,swift 构造器之间的代理必须遵循以下3条规则
 1.指定构造器必须调用其直接父类的指定构造器
 2.便利构造器必须调用相同类中定义的其他构造器
 3.便利构造器最后必须调用指定构造器
 */

/**
两段式构造过程
 
 swift中类的构造过程包含两个阶段
 1.类中的每个存储型属性赋一个初始值,当每个存储型属性的初始值被赋值后,第二阶段开始
 2.给每个类一次机会,在新实例准备使用之前进一步自定义他们的存储型属性
 */

/**
 swift编译器将执行4种有效的安全检查,以确保两段式构造过程不出错
 
 安全检查1: 指定构造器必须保证它所在类的所有属性都初始化完成,之后才能将其他构造任务向上代理给父类中的构造器
 安全检查2:指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器,如果没这样做,指定构造器赋予的新值将被父类中的构造器所覆盖
 安全检查3:便利构造器必须为任意属性赋新值之前代理调用其他构造器,如果没这么做,便利构造器赋予的新值将被该类的指定构造器所覆盖
 安全检查4:构造器在第一阶段构造完成之前,不能调用任何实例方法,不能读取任何实例属性的值,不能引用self作为一个值
 */
class Vehicle {
    var numberOfwheels = 0
    var description: String {
        return "\(numberOfwheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfwheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() 在这里被隐式调用
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")

/**
 构造器的自动继承
 
 子类在默认情况下不会继承父类的构造器,但是如果满足特定条件,父类构造器是可以被自动继承的
 
 1.如果子类没有定义任何指定构造器,它将自动继承父类所有的指定构造器
 2.如果子类提供了所有父类指定构造器的实现--无论是通过规则1继承还是提供了自定义实现--它将自动继承父类所有的便利构造器
 */

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

/**
 可失败的构造器 init?() { }
 */
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}

// 枚举类型的可失败构造器
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

/**
 带原始值的枚举类型的可失败构造器
 
 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)
 */
enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

/**
 构造失败的传递
 
 类,结构体,枚举的可失败构造器可以横向代理到它们自己其他的可失败构造器,子类的可失败构造器也能向上代理到父级的可失败构造器
 */
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

/**
 重写一个可失败构造器
 
 子类可以重写父类的可失败构造器,也可以用子类的非可失败构造器重写一个父类的可失败构造器
 子类的非可失败构造器重写父类的可失败构造器时,向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包
 
 ⚠️ 可以使用非可失败构造器重写可失败构造器,反过来却不行
 */
class Document {
    var name: String?
    init() { }
    init?(name: String){
        if name.isEmpty { return nil }
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init?(name: String) {
        super.init(name: name)
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
class UntitledDocument: Document {
    override init() {
        // 强制解包
        super.init(name: "[Untitled]")!
    }
}
var untitledDocument = UntitledDocument()
print(untitledDocument.name!)

// 必要构造器
class SomeClass {
    required init() { }
}
class SomeSubClass: SomeClass {
    // 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符:
    required init() { }
}

// 通过闭包或函数设置属性的默认值
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
