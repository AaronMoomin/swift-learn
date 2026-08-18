import SwiftUI

struct User {
    let name: String
    let age: Int
}

class UserViewModel {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var userName: String {
        return "Name: \(user.name)"
    }
    
    var userAge: String {
        return "Age: \(user.age)"
    }
}

struct UserView: View {
    let viewModel: UserViewModel
    var body: some View {
        VStack {
            Text(viewModel.userName)
            Text(viewModel.userAge)
        }
    }
}

let user = User(name: "John Doe", age: 30)
let viewModel = UserViewModel(user: user)
let userView = UserView(viewModel: viewModel)
