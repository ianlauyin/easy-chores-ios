
import Foundation


class UserViewModel: ObservableObject, Identifiable{
    @Published var id: Int? = nil
    @Published var username:String? = nil
    @Published var email:String? = nil
    
    init(id: Int? = nil, username: String? = nil, email: String? = nil) {
        //Need to change
        self.id = id
        self.username = username
        self.email = email
    }
    
    
    @MainActor
    func getUserGroup() async throws -> [GroupViewModel] {
        if let id = id {
            do {
                let jsonData = try await APIManager.request.get(url: "/users/\(id)/groups")
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let groups = jsonObject as? [[String: Any]] else {
                    throw APIError.invalidReponseData
                }
                
                var groupViewModels: [GroupViewModel] = []
                for group in groups {
                    let groupViewModel = GroupViewModel(id: group["id"] as? Int, name: group["name"] as? String)
                    groupViewModels.append(groupViewModel)
                }
                return groupViewModels
            } catch {
                throw APIError.invalidReponseData
            }
        } else {
            throw APIError.invalidData
        }
    }
}

let previewUserViewModel = UserViewModel(id: 2, username: "Ian", email: "ianlauyin@gmail.com")
