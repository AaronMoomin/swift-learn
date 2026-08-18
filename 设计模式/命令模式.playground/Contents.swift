
/**
 1. 命令（Command）：定义执行操作的接口。
 2. 具体命令（Concrete Command）：实现命令接口，负责调用接收者的操作。
 3. 接收者（Receiver）：知道如何执行与请求相关的操作。
 4. 调用者（Invoker）：持有命令对象，并在适当的时候调用命令对象的执行方法。
 5. 客户端（Client）：创建命令对象并设置其接收者。
 */

// 1.
protocol Command {
    func execute()
}

// 3.
class Light {
    func turnOn() {
        print("light is on")
    }
    
    func turnOff() {
        print("light is off")
    }
}

// 2.
class LightOnCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOn()
    }
}

class LightOffCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOff()
    }
}

// 4.
class RemoteControl {
    private var command: Command?
    
    func setCommand(command: Command) {
        self.command = command
    }
    
    func pressButton() {
        command?.execute()
    }
}
let light = Light()
let lightOnCommand = LightOnCommand(light: light)
let lightOffCommand = LightOffCommand(light: light)

let remoteControl = RemoteControl()

remoteControl.setCommand(command: lightOnCommand)
remoteControl.pressButton()  // 输出: Light is on

remoteControl.setCommand(command: lightOffCommand)
remoteControl.pressButton()  // 输出: Light is off
