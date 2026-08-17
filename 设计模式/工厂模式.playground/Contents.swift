
/**
 
 核心: 将对象的创建过程封装在一个单独的类或方法中
 
 1. 解耦
 2. 可扩展性
 3. 可维护性
 
 类型:
 1. 简单工厂模式: 通过一个工厂类来创建不同类型的对象
 2. 工厂方法模式: 定义一个创建对象的接口, 但由子类决定实例化哪个类
 3. 抽象工程模式: 提供一个创建一系列相关或相互依赖对象的接口,而无需指定他们具体的类
 */

protocol Button {
    func render()
}

class IosButton: Button {
    func render() {
        print("ios button")
    }
}

class AndroidButton: Button {
    func render() {
        print("android button")
    }
}

protocol ButtonFactory {
    func createButton() -> Button
}

class IosButtonFactory: ButtonFactory {
    func createButton() -> Button {
        return IosButton()
    }
}

class AndroidButtonFactory: ButtonFactory {
    func createButton() -> Button {
        return AndroidButton()
    }
}

let iosFactory = IosButtonFactory()
let iosButton = iosFactory.createButton()
iosButton.render() // 输出: 渲染一个iOS风格的按钮

let androidFactory = AndroidButtonFactory()
let androidButton = androidFactory.createButton()
androidButton.render() // 输出: 渲染一个Android风格的按钮
