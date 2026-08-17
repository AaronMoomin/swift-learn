// 在模式匹配中使用 let 或 var 关键字将匹配的值绑定到变量或常量中
let someValue = 42

switch someValue {
case let x:
    print("The value is \(x)")
}

// 与枚举结合
enum NetworkResult {
    case success(data: String)
    case failue(data: String)
}
let result = NetworkResult.success(data: "success")
switch result {
case .success(let data):
    print("received data is \(data)")
case .failue(let error):
    print("error: \(error)")
}

// 与元祖结合
let coordinate = (x: 10, y: 20)

switch coordinate {
case (let x, let y):
    print("Coordinate is at (\(x), \(y))")
}

// if case 结合
if case .success(let data) = result {
    print("data received: \(data)")
}

// 嵌套模式
let optionalValue: Int? = 10
let nestedOptionalValue: Int?? = optionalValue
// .some(.some(let value)) 直接提取出最内层的值，而不需要多次解包
if case .some(.some(let value)) = nestedOptionalValue {
    print("The value is \(value)")
} else {
    print("No value found")
}
