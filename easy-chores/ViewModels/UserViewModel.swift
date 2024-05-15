
import Foundation


class UserViewModel: ObservableObject{
    @Published private var userModel :UserModel
    var id: Int {return userModel.id}
    var username: String? {return userModel.username}
    var email: String? {return userModel.email}
    
    init(userId : Int){
        // Need to Change this code into request get User Data
        self.userModel = UserModel(id: userId, username: "ian", email: "ianlauyin@gmail.com")
    }
    
    func getUserGroup(completion: @escaping (Result<[GroupModel],APIError>) -> Void){
        APIManager.request.get(url: "/users/\(id)/groups") { result in
            switch result {
            case .success(let jsonData):
                do{
                    let groups = try JSONDecoder().decode([GroupModel].self, from: jsonData)
                    var groupModels:[GroupModel]=[]
                    for group in groups{
                        let group = GroupModel(id: group.id,name: group.name)
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

let previewUserViewModel = UserViewModel(userId: 2)
