
class Person {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
        print("\(name) 被初始化")
    }
    deinit {
        print("\(name) 被销毁")
    }
}

class Apartment {
    let unit: String
    var tenant: Person?
    // weak var tenant: Person? // 弱引用
    // unowned var tenant: Person // 无主引用 假定的引用对象永远不会为nil
    init(unit: String) {
        self.unit = unit
        print("公寓 \(unit) 被初始化")
    }
    deinit {
        print("公寓 \(unit) 被销毁")
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John")      // John 被初始化
unit4A = Apartment(unit: "4A")   // 公寓 4A 被初始化

john!.apartment = unit4A         // John 引用公寓 4A
unit4A!.tenant = john            // 公寓 4A 引用 John

john = nil                       // John 的引用计数为 1（因为公寓 4A 还在引用他）
unit4A = nil                     // 公寓 4A 的引用计数为 1（因为 John 还在引用它）

// 闭包中的引用循环
// ViewController 持有闭包的强引用，而闭包又捕获了 self，导致引用循环 可用过 [weak self] in 弱引用来解决
class ViewController {
    var onButtonTap: (()->Void)?
    
    init() {
        onButtonTap = { [weak self] in
            self?.doSomething()
        }
    }
    
    func doSomething() {
        print("button tap")
    }
    
    deinit {
        print("ViewController is being deinitialized")
    }
}
var vc:ViewController? = ViewController()
vc = nil

// 父子对象关系
class Parent {
    var child: Child?
    deinit {
        print("Parent is being deinitialized")
    }
}

class Child {
    unowned var parent: Parent
    init(parent: Parent) {
        self.parent = parent
    }
    deinit {
        print("child is being deinitialized")
    }
}
var parent: Parent? = Parent()
parent?.child = Child(parent: parent!)
parent = nil
