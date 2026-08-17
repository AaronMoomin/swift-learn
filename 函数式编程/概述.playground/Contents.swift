// 函数式编程核心概念
// 1.纯函数
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

// 2.高阶函数
let numbers = [1,2,3,4,5]
let doubled = numbers.map{$0*2}
print(doubled)

// 3.不可变性
let constValue = 10

// 4.函数组合
func addOne(_ x: Int) -> Int {
    return x + 1
}
func multiplyByTwo(_ x: Int) -> Int {
    return x * 2
}
let result = multiplyByTwo(addOne(3))
print(result)
