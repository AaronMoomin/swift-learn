/**
 1. 策略接口（Strategy Protocol）：定义所有具体策略类必须实现的方法。
 2. 具体策略类（Concrete Strategy）：实现策略接口，提供具体的算法实现。
 3. 上下文类（Context）：持有一个策略对象的引用，并通过策略接口调用具体策略的算法。
 */

protocol PaymentStrategy {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) via Credit Card")
    }
}

class AlipayPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) via Alipay")
    }
}

class WeChatPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) via WeChat Pay")
    }
}

class PaymentContext {
    private var strategy: PaymentStrategy
    
    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }
    
    func setStrategy(strategy: PaymentStrategy){
        self.strategy = strategy
    }
    
    func executePayment(amount: Double){
        strategy.pay(amount: amount)
    }
}
let context = PaymentContext(strategy: CreditCardPayment())
context.executePayment(amount: 100.0) // 输出: Paid 100.0 via Credit Card

context.setStrategy(strategy: AlipayPayment())
context.executePayment(amount: 200.0) // 输出: Paid 200.0 via Alipay

context.setStrategy(strategy: WeChatPayment())
context.executePayment(amount: 300.0) // 输出: Paid 300.0 via WeChat Pay
