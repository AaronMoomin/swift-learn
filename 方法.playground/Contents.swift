// 实例方法
class Counter {
    var count = 0
    func increment() {
        // self.count += 1
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset(){
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

// self属性
struct Point {
    var x=0.0,y=0.0
    func isToTheRightOf(x: Double) -> Bool {
        // self 用于区分一个名为 x 的方法形参和一个同样名为 x 的实例属性
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

/*
 从实例方法内部修改值类型
 结构体 和 枚举 值类型,默认情况下,值类型的属性不能在其实例方法内部被修改
 
 然而，如果你需要在特定方法内部修改结构体或枚举的属性，你可以为该方法启用 mutating 行为
 */
struct Point2 {
    var x=0.0,y=0.0
    mutating func moveBy(x deltaX: Double,y deltaY: Double){
//        x += deltaX
//        y += deltaY
        self = Point2(x: x + deltaX,y: y + deltaY)
    }
}
// 需要 var 才允许使用 mutating 方法
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

// 在 mutating 中给self赋值
enum TriStateSwitch {
    case off, low, height
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .height
        case .height:
            self = .off
        }
    }
}
var state: TriStateSwitch = .off {
    didSet {
        print("state 从 \(oldValue) 变成了 \(state)")
    }
}
state.next()
state.next()
state.next()

/*
 类型方法 关键字 static 和 class
 */
class someClass {
    class func someTypeMethod() { }
}
@MainActor
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    // 由于调用 advance(to:) 方法的代码不一定会关注返回值，因此该函数被标记为 @discardableResult 属性
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
@MainActor
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int){
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
