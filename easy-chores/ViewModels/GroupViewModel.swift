
import Foundation

class GroupViewModel: ObservableObject,Identifiable {
    @Published var id: Int? = nil
    @Published var name:String? = nil
    
    init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }

    @MainActor
    func getGroupChores() async throws -> [ChoreViewModel] {
        if let id = id{
            do {
                let jsonData = try await APIManager.request.get(url: "/groups/\(id)/chores")
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let chores = jsonObject as? [[String: Any]] else {
                    throw APIError.invalidReponseData
                }
                var choreViewModels:[ChoreViewModel]=[]
                for chore in chores{
                    let choreViewModel = ChoreViewModel(
                        id: chore["id"] as? Int,
                        title: chore["title"] as? String,
                        createdAt: chore["created_at"] as? String ,
                        assignedUsers : chore["assigned_users"] as? [String] ?? [])
                    choreViewModels.append(choreViewModel)
                }
                return choreViewModels
            } catch {
                throw APIError.invalidReponseData
            }
        }else{
            throw APIError.invalidData
        }
    }
    
    @MainActor
    func getGroupUsers() async throws -> [UserViewModel]{
        if let id = id{
            do {
                let jsonData = try await APIManager.request.get(url: "/groups/\(id)/users")
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let users = jsonObject as? [[String: Any]] else {
                    throw APIError.invalidReponseData
                }
                var userViewModels:[UserViewModel]=[]
                for user in users{
                    let userViewModel = UserViewModel(
                        id: user["id"] as? Int,
                        username: user["username"] as? String)
                    userViewModels.append(userViewModel)
                }
                return userViewModels
            } catch {
                throw APIError.invalidReponseData
            }
        }else{
            throw APIError.invalidData
        }
    }
    
    @MainActor
    func getGroupGroceries() async throws -> [GroceryViewModel] {
        if let id = id{
            do {
                let jsonData = try await APIManager.request.get(url: "/groups/\(id)/groceries")
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                guard let groceries = jsonObject as? [[String: Any]] else {
                    throw APIError.invalidReponseData
                }
                var groceryViewModels:[GroceryViewModel]=[]
                for grocery in groceries{
                    let groceryViewModel = GroceryViewModel(
                        id: grocery["id"] as? Int,
                        name: grocery["name"] as? String,
                        quantity: grocery["quantity"] as? Int,
                        createdAt: grocery["created_at"] as? String ,
                        creatorName : grocery["creator__username"] as? String)
                    groceryViewModels.append(groceryViewModel)
                }
                return groceryViewModels
            } catch {
                throw APIError.invalidReponseData
            }
        }else{
            throw APIError.invalidData
        }
    }
}

let previewGroupViewModel = GroupViewModel(id: 1, name: "Group1")
