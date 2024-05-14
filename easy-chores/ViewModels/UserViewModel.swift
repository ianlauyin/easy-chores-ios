
import Foundation

class UserViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(id: Int, username: String, email: String? = nil) {
        self.user = UserModel(id:id, username: username, email: email)
        }

}
