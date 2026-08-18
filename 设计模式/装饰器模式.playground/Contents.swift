
/**
 1. 组件（Component）：定义了一个接口，可以是协议或基类，表示被装饰的对象。
 2. 具体组件（Concrete Component）：实现了组件接口的具体类。
 3. 装饰器（Decorator）：持有一个组件对象，并实现了组件接口。它可以在调用组件的方法前后添加额外的行为。
 4. 具体装饰器（Concrete Decorator）：实现了装饰器接口的具体类，负责添加新的功能。
 */

// 1. 组件
protocol Coffee {
    func cost() -> Double
    func description() -> String
}

//2. 具体组件
class SimpleCoffee: Coffee {
    func cost() -> Double { return 5.0 }
    func description() -> String { return "Simple Coffee" }
}

//3. 装饰器
class CoffeeDecorator: Coffee {
    private let decoratedCoffee: Coffee
    init(_ decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }
    
    func cost() -> Double {
        return decoratedCoffee.cost()
    }
    
    func description() -> String {
        return decoratedCoffee.description()
    }
}

// 4. 具体装饰器
class MilkDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 2.0
    }
    
    override func description() -> String {
        return super.description() + ", Milk"
    }
}
class SugarDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 1.0
    }
    
    override func description() -> String {
        return super.description() + ", Sugar"
    }
}
// 5. 使用装饰器
let coffee: Coffee = SimpleCoffee()
print("Cost: \(coffee.cost()), Description: \(coffee.description())")

let milkCoffee: Coffee = MilkDecorator(coffee)
print("Cost: \(milkCoffee.cost()), Description: \(milkCoffee.description())")

let sugarMilkCoffee: Coffee = SugarDecorator(milkCoffee)
print("Cost: \(sugarMilkCoffee.cost()), Description: \(sugarMilkCoffee.description())")
