
struct Person {
    var name: String
    var age: Int
}

let person = Person(name: "aaron", age: 22)
let mirror = Mirror(reflecting: person)
for child in mirror.children {
    print("Property: \(child.label ?? "Unknown"), Value: \(child.value)")
}
print(mirror.subjectType)

func toDictionary<T>(_ object: T) -> [String: Any] {
    let mirror = Mirror(reflecting: object)
    var dictionary = [String: Any]()
    for child in mirror.children {
        if let key = child.label {
            dictionary[key] = child.value
        }
    }
    return dictionary
}
let personDict = toDictionary(person)
print(personDict)
