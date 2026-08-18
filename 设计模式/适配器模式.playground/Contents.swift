
/**
 当你需要使用一个现有的类，但其接口与你的代码不兼容时
 当你希望创建一个可复用的类，该类可以与多个不相关的类协同工作
 */

protocol NewPrinter {
    func print(_ text: String)
}
class OldPrinter {
    func printText(_ text: String) {
        print("Old Printer: \(text)")
    }
}
class PrinterAdapter: NewPrinter {
    private let oldPrinter: OldPrinter
    
    init(oldPrinter: OldPrinter) {
        self.oldPrinter = oldPrinter
    }
    
    func print(_ text: String) {
        oldPrinter.printText(text)
    }
}
let oldPrinter = OldPrinter()
let adapter = PrinterAdapter(oldPrinter: oldPrinter)

adapter.print("Hello, World!")
