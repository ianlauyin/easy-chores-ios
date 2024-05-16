
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
    
    func getUserGroup(completion: @escaping (Result<[GroupViewModel],APIError>) -> Void){
        if let id = id {
            APIManager.request.get(url: "/users/\(id)/groups") { result in
                switch result {
                case .success(let jsonData):
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        guard let groups = jsonObject as? [[String: Any]] else {
                            completion(.failure(.invalidReponseData))
                            return
                        }
                        var groupViewModels:[GroupViewModel]=[]
                        for group in groups{
                            let groupViewModel = GroupViewModel(id: group["id"] as? Int,name: group["name"] as? String)
                            groupViewModels.append(groupViewModel)
                        }
                        completion(.success(groupViewModels))
                    }catch{
                        completion(.failure(.invalidReponseData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        else{
            completion(.failure(.invalidData))
        }
    }
}

let previewUserViewModel = UserViewModel(id: 2, username: "Ian", email: "ianlauyin@gmail.com")
