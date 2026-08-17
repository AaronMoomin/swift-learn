
// 绑定值
let point = (x:10, y:20)
switch point {
case (let x,let y):
    print("x: \(x),y:\(y)")
}

// 匹配特定值
let someValue = 42
switch someValue {
case 0:
    print("value is zero")
case let x where x > 0:
    print("value is positive:\(x)")
case let x where x < 0:
    print("value is negative:\(x)")
default:
    print("value is unknown")
}

// 结合if case 和 guard case
let optionalValue:Int? = 42
if case .some(let value) = optionalValue {
    print("value is \(value)")
} else {
    print("value is nil")
}
