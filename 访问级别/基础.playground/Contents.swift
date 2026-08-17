/**
 open：允许实体在模块内外被访问和继承
 public：允许实体在模块内外被访问，但不能在模块外被继承
 internal：默认访问级别，允许实体在模块内被访问，但在模块外不可见
 fileprivate：限制实体仅在定义它的源文件内可见
 private：限制实体仅在定义它的作用域内可见
 */

/**
 public 定义一个公开的类
 1. 继承限制: public类不能被继承
 2. 方法重写限制: public方法不能在之类中被重写
 
 public 访问级别不允许跨模块继承或重写。如果你需要这些功能，请使用 open 关键字
 */
open class PublicClass {
    public var publicProperty: String = "Public Property"
    
    public func publicMehtod(){
        print("this is a public method")
    }
}

// open 和 public 的区别在于，open 允许其他模块继承和重写类或方法，而 public 只允许访问，不允许继承
open class OpenClass: PublicClass {
    open func openMethod(){
        print("this is an open method")
    }
}

// internal 定义一个内部类
// 如果你没有显式指定访问级别，Swift 会默认使用 internal
/**
 1. 默认访问级别: 如果没有指定访问级别, 实体自动获得内部访问级别
 2. 模块内可见: 内部访问的实体可以在定义它们的模块内自由访问
 3. 模块外不可见: 内部访问的实体在模块外是不可见的
 */
internal class InternalClass {
    internal var internalProperty: String = "Internal String"
    
    internal func internalMethod() {
        print("internal method")
    }
}

// fileprivate 仅在定义它的源文件内可见
// fileprivate 的作用范围是整个源文件，而不是单个类或结构体
/**
 主要目的是为了封装代码, 防止其他文件意外访问或修改不应暴露的实现细节
 */
fileprivate class FileprivateClass {
    fileprivate var fileprivateProperty: String = "Fileprivate Property"
    
    fileprivate func fileprivateMethod(){
        print("fileprivate method")
    }
}

// private 的作用范围是定义它的作用域，例如类、结构体或枚举的内部
private class PrivateClass {
    private var privateProperty: String = "Private Property"
        
    private func privateMethod() {
        print("This is a private method.")
    }
}

// 封装内部实现
class BankAccount {
    // 内部属性
    private var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if amount <= balance {
            balance -= amount
            return true
        } else {
            return false
        }
    }
    
    func getBalance() -> Double {
        return balance
    }
}
