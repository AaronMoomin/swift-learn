// 处理可选值
let optionalValue: Int? = 5

if case .some(_) = optionalValue {
    print("the optional value is not nil")
} else {
    print("the optional value is nil")
}

// 忽略函数返回值
func doSomething() -> Int {
    return 42
}
_ = doSomething()
