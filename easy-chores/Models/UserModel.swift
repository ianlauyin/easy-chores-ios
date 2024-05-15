

import Foundation

class UserModel: ObservableObject, Identifiable{
    @Published var id: Int? = nil
    @Published var username:String? = nil
    @Published var email:String? = nil
    
    init(userId : Int? = nil){
        // Need to Change this code into request get User Data
        if userId != nil{
            self.id = userId
            self.username = "ian"
            self.email = "ianlauyin@gmail.com"
        }
    }
    func getUserGroup(completion: @escaping (Result<[GroupModel],APIError>) -> Void){
        guard let userId = id else {
                return
            }
        APIManager.request.get(url: "/users/\(userId)/groups") { result in
            switch result {
            case .success(let jsonData):
                do{
                    let groups = try JSONDecoder().decode([GroupDataDecorder].self, from: jsonData)
                    var groupModels:[GroupModel]=[]
                    for group in groups{
                        let group = GroupModel(id: group.id, name: group.name)
                        groupModels.append(group)
                    }
                    completion(.success(groupModels))
                }catch{
                    completion(.failure(.invalidReponseData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}

struct UserDataDecorder:Codable{
    var id: Int? = nil
    var username:String? = nil
    var email:String? = nil
}
