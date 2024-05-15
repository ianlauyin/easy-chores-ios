

import Foundation


struct UserModel:Codable,Identifiable{
    let id: Int
    var username:String? = nil
    var email:String? = nil
    
    
}

let previewUser = UserModel(id: 2, username: "test user", email: "testuser@test.com")
