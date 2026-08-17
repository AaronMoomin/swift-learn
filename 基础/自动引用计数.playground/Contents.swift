// 引用计数(ARC) 只管理class

// 为什么struct 不需要 ARC, 因为struct 赋值是副本不是引用
class PersonARC {
    let name: String

    init(name: String) {
        self.name = name
        print("\(name) init")
    }

    deinit {
        print("\(name) deinit")
    }
}
var p1: PersonARC? = PersonARC(name: "Tom")
var p2 = p1
var p3 = p1
p1=nil
p2=nil
p3=nil

// ‼️ 强引用循环
class Person {
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) deinit")
    }
}

class Apartment {
    let unit: String
    // weak解决循环引用 需要使用optional
    weak var tenant: Person?

    init(unit: String) {
        self.unit = unit
    }
    deinit {
        print("Apartment deinit")
    }
}
var john: Person? = Person(name: "John")
var room: Apartment? = Apartment(unit: "101")
// 由于互相引用 所以deinit永远不会执行(内存泄露)

// 必包导致的循环引用
class ViewModel {
    var completion: (()->Void)?
    deinit {
        print("ViewModel deinit")
    }
    func load(){
        completion = { [weak self] in
            guard let self else {
                return
            }
            print(self)
        }
    }
}
var vm: ViewModel? = ViewModel()
vm?.load()
vm = nil

// weak和unowned对比
// weak 自动置nil 必须Optional 安全
// unowned 不置nil 不是Optional 性能更好 (引用对象比自己活得久 就用unowned)

// weak
class Owner {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
class Pet {
    // 不确定是否存在
    weak var owner: Owner?
}

// unowned
class Customer {
    let name: String = ""
    var card: CreditCard?
}
class CreditCard {
    let number: Int
    // 如果对象一定存在 使用unowned
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
}
