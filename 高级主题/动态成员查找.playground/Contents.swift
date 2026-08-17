
@dynamicMemberLookup
struct Person {
    var name: String
    var age: Int
    
    subscript(dynamicMember member: String) -> String {
        switch member {
        case "name":
            return name
        case "age":
            return "\(age)"
        default:
            return "unknown"
        }
    }
}
let person = Person(name: "Alice", age: 30)
print(person.name) // 输出: Alice
print(person.age)  // 输出: 30
print(person.unknown) // 输出: Unknown

// 处理JSON数据
@dynamicMemberLookup
struct JSON {
    private var data: [String: Any]
    
    init(data: [String : Any]) {
        self.data = data
    }
    
    subscript(dynamicMember member: String) -> Any? {
        return data[member]
    }
}
let json = JSON(data: ["name": "Bob", "age": 25, "address": ["city": "New York", "zip": "10001"]])
print(json.name) // 输出: Optional("Bob")
print(json.age)  // 输出: Optional(25)
print(json.address) // 输出: Optional(["city": "New York", "zip": "10001"])
