/**
 允许一个对象在其状态发生变化时, 自动通知并更新一组依赖他的对象
 核心: 松耦合
 1. 主题
 2. 观察者
 
 */
protocol Observer: AnyObject {
    func update(data: String)
}

class Subject {
    private var observers = [Observer]()
    private var state: String = ""
    
    func attach(observer: Observer) {
        observers.append(observer)
    }
    
    func detach(observer: Observer) {
        observers.removeAll { $0 === observer }
    }
    
    func setState(_ state: String) {
        self.state = state
        notifyObservers()
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.update(data: state)
        }
    }
}

class ConcreteObserver: Observer {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(data: String) {
        print("\(name) received update: \(data)")
    }

}
let subject = Subject()

let observer1 = ConcreteObserver(name: "Observer 1")
let observer2 = ConcreteObserver(name: "Observer 2")

subject.attach(observer: observer1)
subject.attach(observer: observer2)

subject.setState("New State")
