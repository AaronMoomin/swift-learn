let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// 闭包
var reversedNames = names.sorted(by: {(s1,s2) in s1 > s2})
print(reversedNames)
// 闭包简写
var reversedNames_simple = names.sorted { $0 > $1 }
print(reversedNames_simple)
// 运算符
var reversedNames_operator = names.sorted(by: >)
print(reversedNames_operator)

// 尾随闭包
func someFunctionThatTakesAClosure(closure: () -> Void){}
// 不使用尾随闭包
someFunctionThatTakesAClosure(closure: {})
// 使用尾随闭包
someFunctionThatTakesAClosure() {}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map { number -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
print(strings)

// 值捕获
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func increment() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return increment
}
let increment = makeIncrementer(forIncrement: 10)
print(increment())
print(increment())
print(increment())

// 逃逸闭包
var completionHandlers: [() -> Void] = []
// someFunctionWithEscapingClosure(_:) 函数将闭包作为其参数
// 并将其添加到函数外部声明的数组中。如果不用 @escaping 标记此函数的参数，则会收到编译错误。
@MainActor
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNoneEscapingClosure(closure: () -> Void) {
    closure()
}
@MainActor
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoneEscapingClosure {  x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x) // 200
completionHandlers.first?()
print(instance.x) // 100

// 自动闭包
// 自动闭包允许您延迟计算，因为在你调用这个闭包之前，内部代码不会运行。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
let customerProvider  = { customersInLine.remove(at: 0) }
print(customersInLine.count)
print("Now serving \(customerProvider())!")
print(customersInLine.count)

var customerProviders: [()->String] = []
@MainActor
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping ()-> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))
print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
