/**
 为什么需要 Actor 模型？
 在传统的并发编程中，多个线程可能会同时访问和修改共享数据，这可能导致数据竞争（Data Race）和不可预测的行为。Actor 模型通过以下方式解决了这些问题：

 数据隔离：每个 Actor 都有自己的状态，其他 Actor 无法直接访问或修改它。
 消息传递：Actor 之间通过发送消息进行通信，消息是异步处理的，确保了线程安全。
 顺序执行：每个 Actor 内部的消息是按顺序处理的，避免了并发问题。
 */
import SwiftUI

actor BankAccount {
    private var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) async -> Double {
        if balance >= amount {
            balance -= amount
            return amount
        } else {
            return 0.0
        }
    }

    func getBalance() async -> Double {
        return balance
    }
}

let account = BankAccount()
Task {
    await account.deposit(amount: 100.0)
    let balance = await account.getBalance()
    print("Current balance: \(balance)")
}
Task {
    let withdrawnAmount = await account.withdraw(amount: 50.0)
    print("Withdrawn amount: \(withdrawnAmount)")
    let balance = await account.getBalance()
    print("Current after withdrawn: \(balance)")
}
