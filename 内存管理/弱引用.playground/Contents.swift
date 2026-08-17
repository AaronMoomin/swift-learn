import SwiftUI
// 1. 委托模式
protocol TaskDelegate: AnyObject {
    func taskDidComplete()
}
class Task {
    weak var delegate: TaskDelegate?
    
    func complete(){
        delegate?.taskDidComplete()
    }
}
class TaskManager: TaskDelegate {
    var task: Task?
    func startTask() {
        task = Task()
        task?.delegate = self
        task?.complete()
    }
    
    func taskDidComplete() {
        print("Task Completed!")
    }
}
let manager = TaskManager()
manager.startTask()

// 2.闭包中的弱引用
class DataLoader {
    var onDataLoaded: (()->Void)?
    
    func loadData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.handleDataLoaded()
        }
    }
    
    func handleDataLoaded() {
       print("Data loaded!")
   }

   deinit {
       print("DataLoader is being deinitialized")
   }
}
var loader: DataLoader? = DataLoader()
loader?.onDataLoaded = {
    print("Data loaded callback")
}
loader?.loadData()
loader = nil
