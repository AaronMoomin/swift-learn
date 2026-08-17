
/**
 高阶函数
 1. 接受一个或多个函数作为参数
 2. 返回一个函数作为结果
 
 */
// map
let numbers = [1, 2, 3, 4, 5]
let squaredNumbers = numbers.map { $0 * $0 }
print(squaredNumbers) // 输出: [1, 4, 9, 16, 25]

// compactMap 自动过滤nil
let numbers2: [Int?] = [1, 2, nil, 4, nil, 5]
let nonNilNumbers = numbers2.compactMap { $0 }
print(nonNilNumbers)

// flatMap 拉直数组且自动过滤nil
let nestedArray = [[1, 2, 3], [4, 5], [6, 7, 8]]
let flattenedArray = nestedArray.flatMap { $0 }
print(flattenedArray)

// filter
let evenNumbers = numbers.filter { $0 % 2 == 0 }
print(evenNumbers) // 输出: [2, 4]

// reduce
let sum = numbers.reduce(0, { $0 + $1 })
print(sum) // 输出: 15

// 函数组合 将两个或多个函数结合在一起，形成一个新的函数
func addOne(_ x: Int) -> Int { return x + 1 }
func multiplyByTwo(_ x: Int) -> Int { return x * 2 }
// @escaping 是 Swift 里给闭包的标记，表示这个闭包可能在当前函数返回后才执行
func compose<A,B,C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    return { x in g(f(x))}
}
let addOneThenMultiplyByTwo = compose(addOne, multiplyByTwo)
let result = addOneThenMultiplyByTwo(3)

// 柯里化
/**
 
 优势
 1. 模块化：柯里化允许我们将函数分解为更小的、可重用的部分。
 2. 灵活性：通过柯里化，我们可以逐步应用参数，从而创建更灵活的函数组合。
 3. 可读性：柯里化可以使代码更具可读性，尤其是在处理复杂配置或依赖注入时。

 */
func add(_ a: Int, _ b: Int) -> Int { return a + b }
func addCurried(a: Int) -> (Int) -> Int {
    return { b in
        return a + b
    }
}
let addTwo = addCurried(a: 2)
let result1 = addTwo(3)

// 偏函数 通过固定一个函数的部分参数来创建一个新的函数
func addFive(_ b: Int) -> Int { return add(5, b) }
