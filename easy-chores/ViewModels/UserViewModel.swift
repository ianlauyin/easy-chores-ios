
import Foundation


class UserViewModel: ObservableObject, Identifiable{
    @Published var id: Int? = nil
    @Published var username:String? = nil
    @Published var email:String? = nil
    
    init(id: Int? = nil, username: String? = nil, email: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
    }
}
