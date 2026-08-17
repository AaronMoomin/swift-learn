
/**
 任务优先级的基本概念
 在Swift中，任务的优先级是通过TaskPriority枚举来定义的。TaskPriority枚举包含以下几个优先级级别：

 .userInitiated：用户发起的任务，需要立即执行。
 .utility：实用任务，不需要立即执行，但需要在合理的时间内完成。
 .background：后台任务，可以在系统资源允许的情况下执行。
 .default：默认优先级，介于.userInitiated和.utility之间。
 
 优先级只是一个提示，系统可能会根据实际情况调整任务的执行顺序。
 */
Task(priority: .background) {
    print("低优先任务开始执行")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("低优先任务执行完毕")
}

Task(priority: .userInitiated) {
    print("高优先任务开始执行")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("高优先任务执行完毕")
}

/**
 优先级继承
 在Swift中，任务的优先级可以继承自其父任务。这意味着，如果一个任务是在另一个任务中创建的，那么子任务的优先级通常会与父任务相同
 */
Task(priority: .userInitiated) {
    print("父任务开始执行")
    Task {
        print("子任务开始执行")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("子任务执行完毕")
    }
    print("父任务执行完毕")
}
