
/**
 核心: 限制类的实例化次数
 1. 私有化构造函数
 2. 静态属性
 */

class Singleton {
    // 静态属性，用于存储单例实例
    @MainActor static let shared = Singleton()
    
    // 私有化构造函数，防止外部代码创建实例
    private init() {}
    
    // 示例方法
    func doSomething() {
        print("Singleton is doing something!")
    }
}
Singleton.shared.doSomething()
