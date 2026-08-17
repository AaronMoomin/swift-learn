// 访问级别
/**
open和public允许实体被同一模块的任意源文件使用,也可以在导入该模块的其他模块的源文件内使用,通常使用open和public访问级别来指定框架的公共接口,open允许模块外的代码进行继承和重写
 
 package允许实体被同一模块的任意源文件使用,但不能在包外的源文件内使用,通常在包含多个模块的应用或框架中使用package
 
 internal允许实体被同一模块的任意源文件使用,但不能在模块外的源文件中使用,通常在定义应用或框架的内部结构体时使用
 
 fileprivate将对实体的使用限制在定义它的源文件内,当某个功能的实现细节只需要在当前文件中使用时,可以使用fileprivate来隐藏这些实现细节
 
 private将对实体的使用限制在其声明的作用域内,以及同一文件中该声明的扩展内,当某个功能的实现细节只在单个声明内使用时,可以使用private来隐藏这些实现细节
 
 */

// 访问级别遵循一个指导原则: 实体的定义都不能依赖于访问级别更低(更严格)的其他实体

// 默认访问级别: 在代码中,所有实体(除了一些特例)如果没有显式指定访问级别,那么默认的访问级别是internal

// 单Target应用程序的访问级别: 当你编写一个简单的单Target应用程序时,这些代码通常都只供自己使用,而不需要在应用模块之外使用,因为默认的internal访问级别就已经满足了这个需求,所以无需额外指定访问级别,但是你也可以将某些代码的访问级别指定为fileprivate或private,以便在模块内隐藏这部分代码的实现细节

//框架的访问级别: 当你开发框架时,应将框架的对外接口指定为open或public,以便其他模块(如导入该框架的应用)可以查看和访问这些接口,这个对外接口就是框架的API(application programming interface)

// 单元测试Target的访问级别: 当你编写包含单元测试target的应用程序时,需要将应用程序中的代码暴露给该模块以便进行测试,默认情况下,只有指定open或public的实体才能被其他模块访问,不过如果你在导入产品模块时使用了 @textable属性,并且在编译时启用了测试选项,那么单元测试target就可以访问所有internal实体

// 访问控制语法
public class SomePunlicClass {}
internal struct SomeInternalStruct {}
private func somePrivateFunction() {}

// 自定义类型
public class SomePublicClass {                   // 显式指定为 public 类
    public var somePublicProperty = 0            // 显式指定为 public 类成员
    var someInternalProperty = 0                 // 隐式指定为 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}

class SomeInternalClass {                        // 隐式指定为 internal 类
    var someInternalProperty = 0                 // 隐式指定为 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}

fileprivate class SomeFilePrivateClass {         // 显式指定为 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式指定为 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式指定为 private 类成员
}

private class SomePrivateClass {                 // 显式指定为 private 类
    func somePrivateMethod() {}                  // 隐式指定为 private 类成员
}

// 元祖类型的访问级别: 由元祖中访问级别最严格的类型决定,元祖类型不像类,结构体,枚举和函数那样有单独的定义,是根据构成该元祖类型的各个类型的访问级别自动确定的,⚠️不能显示指定
