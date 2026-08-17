
// 匹配常量
let number = 42
switch number {
case 0:
    print("Zero")
case 42:
    print("The answer to life, the universe, and everything")
default:
    print("Some other number")
}

// 匹配元祖
let point = (1,2)
switch point {
case (0, 0):
    print("Origin")
case (_, 0):
    print("On the x-axis")
case (0, _):
    print("On the y-axis")
case (-2...2, -2...2):
    print("Inside the 2x2 box")
default:
    print("Somewhere else")
}

// 匹配枚举
enum CompassDirection {
    case north, south, east, west
}

let direction = CompassDirection.north

switch direction {
case .north:
    print("Heading north")
case .south:
    print("Heading south")
case .east:
    print("Heading east")
case .west:
    print("Heading west")
}

// 高级匹配
// 1. 值绑定
let anotherPoint = (2, 0)

switch anotherPoint {
case (let x, 0):
    print("On the x-axis with an x value of \(x)")
case (0, let y):
    print("On the y-axis with a y value of \(y)")
case let (x, y):
    print("Somewhere else at (\(x), \(y))")
}

// 2. where 语句
let yetAnotherPoint = (1, -1)

switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
