
@propertyWrapper
struct Capitalized {
    private var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = value.capitalized }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
struct User {
    @Capitalized var name: String
}

var user = User(name: "john doe")
print(user.name) // 输出: "John Doe"
