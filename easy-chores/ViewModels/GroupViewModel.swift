
import Foundation

class GroupViewModel: ObservableObject,Identifiable {
    @Published var id: Int? = nil
    @Published var name:String? = nil
    
    init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }

    
    func getGroupChores(completion: @escaping (Result<[ChoreViewModel],APIError>) -> Void){
        if let id = id{
            APIManager.request.get(url: "/groups/\(id)/chores") { result in
                switch result {
                case .success(let jsonData):
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        guard let chores = jsonObject as? [[String: Any]] else {
                            completion(.failure(.invalidReponseData))
                            return
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
                        completion(.success(choreViewModels))
                    }catch{
                        completion(.failure(.invalidReponseData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }else{
            completion(.failure(.invalidData))
        }
    }
    
    func getGroupGroceries(completion: @escaping (Result<[GroceryViewModel],APIError>) -> Void){
        if let id = id{
            APIManager.request.get(url: "/groups/\(id)/groceries") { result in
                switch result {
                case .success(let jsonData):
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        guard let groceries = jsonObject as? [[String: Any]] else {
                            completion(.failure(.invalidReponseData))
                            return
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
                        completion(.success(groceryViewModels))
                    }catch{
                        completion(.failure(.invalidReponseData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }else{
            completion(.failure(.invalidData))
        }
    }
}

let previewGroupViewModel = GroupViewModel(id: 1, name: "Group1")
