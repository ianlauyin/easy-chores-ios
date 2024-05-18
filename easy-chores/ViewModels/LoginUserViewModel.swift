import Foundation


class LoginUserViewModel : ObservableObject{
    @Published var id: Int? = nil
    @Published var username:String? = nil
    
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
                throw error
            }
        } else {
            throw APIError.invalidData
        }
    }
}


let previewLoginUserViewModel = LoginUserViewModel()
