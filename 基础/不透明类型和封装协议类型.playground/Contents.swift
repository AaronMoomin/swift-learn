/**
 不透明类型 和 封装协议类型
 在隔离模块和调用模块的代码上, 隐藏类型信息是有用的, 因为这样返回值的底层类型可以保持私有
 */
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}


let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())

print("----smallTriangle----⬆️")

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())

print("----flippedTriangle----⬆️")

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
       return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())

print("----joinedTriangles----⬆️")

// 返回一个不透明类型
struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}


func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())

print("----trapezoid----⬆️")

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}


let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())

print("----opaqueJoinedTriangles----⬆️")

// 封装协议类型 (存在类型)
// [any Shape] 数组中的元素可以是不同的类型 但是必须遵循Shape协议
struct VerticalShapes: Shape {
    var shapes: [any Shape]
    func draw() -> String {
        return shapes.map { $0.draw() }.joined(separator: "\n\n")
    }
}
let largeTriangle = Triangle(size: 5)
let largeSquare = Square(size: 5)
let vertical = VerticalShapes(shapes: [largeTriangle, largeSquare])
print(vertical.draw())

print("----vertical----⬆️")

/**
 · 使用泛型: 通过编写struct VerticalShapes<S: Shape> 和 var shapes: [S] ,可以创建一个数组, 其元素是某种特定的形状类型, 并且这个特定类型的身份对任何与数组交互的代码都是可见的
 
 · 使用不透明类型: 通过编写var shapes: [any Shape] 来创建一个数组, 其元素是某种特定形状类型,
 并且这个特定类型的身份是隐藏的
 
 · 使用封装协议类型: 通过编写var shapes: [any Shape] 能创建一个可以存储不同类型元素的数组, 并且这些类型的身份是隐藏的
 
 可以在知道被封装的基础类型时使用一个as来进行类型转换
 */
if let downcastTriangle = vertical.shapes[0] as? Triangle {
    print(downcastTriangle.size)
}

// 不透明类型与封装类型之间的区别
func protoFlip<T: Shape>(_ shape: T) -> Shape {
    return FlippedShape(shape: shape)
}

// 定义一个协议
protocol Animal {
    func speak()
}
// 定义两个实现
struct Dog: Animal {
    func speak() {
        print("wang")
    }
}
struct Cat: Animal {
    func speak() {
        print("miao")
    }
}
// 泛型
func makeSound<T: Animal>(_ animal: T) {
    animal.speak()
}

// 不透明类型 some
// 相当于func createAnimal() -> Dog 只是将Dog隐藏起来 编译器知道 但是调用方不知道
// ⚠️ 返回类型必须唯一
func createAnimal() -> some Animal {
    Dog()
}

// 封装协议 any
// 编译器不知道 调用方也不知道
// some的性能比any的好, 因为从一开始就确定了类型
func createAnimal(flag: Bool) -> any Animal {
    if flag {
        return Dog()
    }
    return Cat()
}

// 🏆 泛型<T>是调用者决定类型 some是实现者决定类型 any是运行时决定类型
// 使用频率 泛型 > some >> any
