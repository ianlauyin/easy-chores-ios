
import Foundation

class ChoreViewModel: ObservableObject , Identifiable{
    @Published var id: Int? = nil
    @Published var title: String? = nil
    @Published var createdAt:String? = nil
    @Published var detail:String? = nil
    @Published var completedDate:String? = nil
    @Published var assignedUsers:[String] = []
    private let dateFormatter = DateFormatter()

    init(id: Int? = nil, title: String? = nil, createdAt: String? = nil, detail: String? = nil, completedDate: String? = nil, assignedUsers :[String] = []) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.detail = detail
        self.completedDate = completedDate
        self.assignedUsers = assignedUsers
    }
    
    func doneChore(completedDate:Date,completion: @escaping (Result<Void,APIError>)->Void){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let completedDateString = dateFormatter.string(from: completedDate)
        if let id = id{
            APIManager.request.put(url: "/chores/\(id)",data: ["completed_date":completedDateString]) { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }else{
            completion(.failure(.invalidData))
        }
    }
    
}

let previewUnfinshedChoreViewModel = ChoreViewModel(id: 1, title:"Change bed sheets", createdAt:"2024-05-15", detail: "Change Bed Sheets Ahhhhhhhh!!!", assignedUsers: ["Ian","Claire"])
