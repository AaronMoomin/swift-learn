/**
 值类型
 复制行为：值类型在赋值或传递时会被复制
 独立内存：每个值类型的实例都有自己独立的内存空间
 栈分配：值类型通常分配在栈上，这使得它们的访问速度更快
 */
struct Point {
    var x: Int
    var y: Int
}

var point1 = Point(x: 10, y: 20)
var point2 = point1

point2.x = 30

print(point1.x) // 输出: 10
print(point2.x) // 输出: 30

enum Direction {
    case north
    case east
    case west
    case south
}
var direction1 = Direction.north
var direction2 = direction1

direction2 = .south
print(direction1) // 输出: north
print(direction2) // 输出: south
