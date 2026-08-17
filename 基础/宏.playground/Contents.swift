
/**
 宏 = 编译器帮你自动生成代码
 独立宏: 可独立出现,无需被附加到任何声明中
 附加宏: 会修改它被附加到的声明中
 */

// 独立宏
func myFunction() {
    print("currently running \(#function)")
    #warning("something`s wrong")
}
myFunction()

// 附加宏
//@OptionSet
//struct SundaeToppings {
//    private enum Options: Int {
//        case nuts
//        case cherry
//        case fudge
//    }
//}

// 宏的声明 macro
@attached(member, names: named(RawValue), named(rawValue), named(`init`), arbitrary) // 表示这个宏会向被作用到的类型添加的成员
@attached(extension, conformances: OptionSet) // 声明了 @OptionSet 会添加对OptionSet协议的遵循
public macro OptionSet<RawType>() =
        #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")

/**
 宏的展开
 1.编译器读取代码,创建语法的内存表示
 2.编译器将部分内存表示发送给宏的实现,宏将在此基础上展开
 3.编译器将宏的调用替换为它的展开形式
 4.编译器使用展开后的源代码继续进行编译
 */
print(#file)
print(#line)
