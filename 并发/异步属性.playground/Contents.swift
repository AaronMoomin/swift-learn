
struct UserProfile {
    var userId: Int
    
    var profile: UserProfile {
        get async {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            return UserProfile(userId: userId)
        }
    }
    
    var userName: String {
        get async {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            return "User_\(userId)"
        }
    }
}
func printUserName() async {
    let user = UserProfile(userId: 123)
    let userName = await user.userName
    let profile = await user.profile
    print("Fetched profile for user: \(profile.userId)")
}
Task {
    await printUserName()
}

