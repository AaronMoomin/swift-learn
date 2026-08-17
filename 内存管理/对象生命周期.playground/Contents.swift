/**
 Swift对象的生命周期可以分为以下几个阶段：

 创建（Allocation）：对象在内存中被分配空间。
 初始化（Initialization）：对象的属性被赋予初始值。
 使用（Usage）：对象在程序中被使用。
 释放（Deallocation）：对象从内存中被移除。
 
 */
class Person {
    var name: String
    
    
    // 初始化
    init(name: String) {
        self.name = name
    }
    
    func greet(){
        print("Hello, my name is \(name).")
    }
    
    // 销毁 deinit 方法只适用于类类型，结构体和枚举没有 deinit 方法
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
// 创建
var person: Person? = Person(name: "aaron")
person?.greet()
person = nil
