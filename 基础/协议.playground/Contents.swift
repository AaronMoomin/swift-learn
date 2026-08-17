/**
 ✨ 协议本质上就是一份规范
 */
// 1️⃣ 定义协议
protocol AnimalProtocol {
    func speak()
}
// 2️⃣ 遵循协议
struct Dog: AnimalProtocol {
    func speak() {
        print("woff")
    }
}
struct Cat: AnimalProtocol {
    func speak() {
        print("mi")
    }
}
let dog = Dog()
dog.speak()
let cat = Cat()
cat.speak()

// 3️⃣ 协议作为参数 any AnimalProtocol 表示任何遵守AnimalProtocol的类型
func makeSound(_ animal: AnimalProtocol) {
    animal.speak()
}
makeSound(Dog())
makeSound(Cat())

// 4️⃣ 协议属性 表示必须有name且必须能读写
protocol NamedProtocol {
    var name: String { get set }
}
struct User: NamedProtocol {
    var name: String
}

// 5️⃣ mutating
protocol Switchable {
    mutating func toggle()
}
enum Light: Switchable {
    case on
    case off
    
    mutating func toggle() {
        self = self == .on ? .off : .on
    }
}
var light = Light.off
light.toggle()
print(light)

// 6️⃣ 协议继承
protocol Pet: AnimalProtocol {
    func play()
}
struct PetDog: Pet {
    func play() {
        print("play")
    }
    
    func speak() {
        print("speak")
    }
}

// 7️⃣ 协议扩展 => 提供默认实现
protocol Flyable {
    func fly()
}
extension Flyable {
    func fly() {
        print("Flying....")
    }
}
struct Bird: Flyable { }
Bird().fly()

// 8️⃣ 默认实现+重写 优先使用自己的实现
struct BirdOverride: Flyable {
    func fly() {
        print("Flying by bird")
    }
}
BirdOverride().fly()

// 9️⃣ 实际项目案例
protocol NetworkService {
    func request() async throws -> String
}
struct APIService: NetworkService {
    func request() async throws -> String {
        "Server Data"
    }
}
struct MockService: NetworkService {
    func request() async throws -> String {
        "Mock Data"
    }
}
class ViewModel {
    let service: any NetworkService
    
    init(service: any NetworkService) {
        self.service = service
    }
}
let vmProd = ViewModel(
    service: APIService()
)
let vmMock = ViewModel(
    service: MockService()
)

// 🔟 协议+范型
func makeSound<T: AnimalProtocol>(_ animal: T) {
    animal.speak()
}

// 🔟1️⃣ associatedtype 占位类型
protocol Container {
    associatedtype Item
    
    mutating func append(_ item: Item)
    
    var count: Int { get }
}
struct IntContainer: Container {
    var items: [Int] = []
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        items.count
    }
}

/**
 协议语法
 
 protocol SomeProtocol { }
 多协议
 struct SomeStructure: FirstProtocol, AnotherProtocol { }
 如有父类, 应将父类名放在任何遵循的协议名之前
 class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol { }
 
 protocol SomeProtocol {
     var mustBeSettable: Int { get set }
     var doesNotNeedToBeSettable: Int { get }
     
     // 方法要求
     static func someTypeMethod()
     
     // 变值方法
     mutating func someMutatingMethod()
     
     init()
     // 构造器要求
     init(someParameter: Int)

 }
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "john Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " :" ") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
        let m = 139968.0
        let a = 3877.0
        let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

// 变值方法
protocol Toggable {
    mutating func toggle()
}
enum OnOffSwitch: Toggable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
print(lightSwitch)

protocol SomeProtocol {
    init()
}
class SomeSuperClass {
    init(){ }
}
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的构造器要求，那么该构造器的实现需要同时标注 required 和 override 修饰
    required override init() {
        //
    }
}

// 仅有语义要求的协议
/**
 Sendable 用于可以跨并发域共享的值
 Copyable 用于Swift在传递给函数时可以复制的值
 BitwiseCopyable 用于可以按位复制的值
 */

// 代理
class DiceGame {
    var sides: Int
    var generator = LinearCongruentialGenerator()
    weak var delegate: Delegate?
    
    init(sides: Int) {
        self.sides = sides
    }
    convenience init(sides: Int, generator: RandomNumberGenerator) {
        self.init(sides: sides)
        self.generator = generator as! LinearCongruentialGenerator
    
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    func play(rounds: Int) {
        delegate?.gameDidStart(self)
        for round in 1...rounds {
            let player1 = roll()
            let player2 = roll()
            if player1 == player2 {
                delegate?.game(self, didEndRound: round, winner: nil)
            } else if player1 > player2 {
                delegate?.game(self, didEndRound: round, winner: 1)
            } else {
                delegate?.game(self, didEndRound: round, winner: 2)
            }
        }
        delegate?.gameDidEnd(self)
    }
    
    protocol Delegate: AnyObject {
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didEndRound round: Int, winner: Int?)
        func gameDidEnd(_ game: DiceGame)
    }
}
class DiceGameTracker: DiceGame.Delegate {
    var playerScore1 = 0
    var playerScore2 = 0
    func gameDidStart(_ game: DiceGame) {
        print("Started a new game")
        playerScore1 = 0
        playerScore2 = 0
    }
    
    func game(_ game: DiceGame, didEndRound round: Int, winner: Int?) {
        switch winner {
        case 1:
            playerScore1 += 1
            print("Player 1 won rount \(round)")
        case 2:
            playerScore2 += 1
            print("Player 2 won round \(round)")
        default:
            print("The round was a draw")
        }
    }
    
    func gameDidEnd(_ game: DiceGame) {
        if playerScore1 == playerScore2 {
            print("The game ended in a draw.")
        } else if playerScore1 > playerScore2 {
            print("Player 1 won!")
        } else {
            print("Player 2 won!")
        }
    }
}
let tracker = DiceGameTracker()
let game = DiceGame(sides: 6)
game.delegate = tracker
game.play(rounds: 3)

// 在扩展里添加协议遵循
protocol TextRepresentable {
    var textualDescription: String { get }
}
class Dice {
    var sides: Int
    var generator = LinearCongruentialGenerator()
    
    init(sides: Int) {
        self.sides = sides
    }
    convenience init(sides: Int, generator: RandomNumberGenerator) {
        self.init(sides: sides)
        self.generator = generator as! LinearCongruentialGenerator
    }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

// 有条件地遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d12, d12]
print(myDice.textualDescription)

// 在扩展里声明协议遵循 ⚠️ 即使满足了协议的所有要求,类型也不会自动遵循协议,必须显式遵循协议
// 当一个类型已经遵循了某个协议中的所有要求,却还没有什么遵循协议时,可以通过空的扩展来让它遵循协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable { }
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

// 使用合成实现来遵循协议
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}
let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner, SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels {
    print(level)
}

// 协议组合
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Named, Aged {
    var age: Int
    var name: String
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person1(age: 27, name: "aaron")
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Sattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

/**
 检查是否遵循协议
 is 用来检查实例是否遵循某个协议, 若遵循则返回true, 否则返回false
 as? 返回一个可选值,当实例遵循某个协议时,返回类型为协议类型的可选值, 否则返回nil
 as! 将实例强制向下转换到某个协议类型, 如果强转失败,将触发运行时错误
 */
protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("something that doesn`t have an area")
    }
}

// 协议扩展 -》会提供默认实现
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator1 = LinearCongruentialGenerator()
print("Here`s a random number: \(generator1.random())")
print("Here`s a random number: \(generator1.randomBool())")

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())
print(differentNumbers.allEqual())
