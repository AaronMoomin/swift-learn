let task = Task {
    for i in 1...10 {
        if Task.isCancelled {
            print("任务取消了")
            return
        }
        print("正在执行任务\(i)")
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
task.cancel()

let task2 = Task {
    do {
        for i in 1...10 {
            try Task.checkCancellation()
            print("正在执行任务\(i)")
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
    } catch {
        print("任务取消了\(error)")
    }
}
task2.cancel()
