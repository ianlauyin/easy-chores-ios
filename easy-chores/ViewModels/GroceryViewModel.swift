
import Foundation

class GroceryViewModel: ObservableObject , Identifiable{
    @Published var id: Int?
    @Published var name: String?
    @Published var quantity:Int?
    @Published var createdAt:String?
    @Published var creatorName:String?
    @Published var detail:String?
    
    init(id: Int? = nil, name: String? = nil, quantity: Int? = nil, createdAt: String? = nil, creatorName: String? = nil, detail: String? = nil) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.createdAt = createdAt
        self.creatorName = creatorName
        self.detail = detail
    }
    
    func doneGrocery(completion: @escaping (Result<Void,APIError>)->Void){
        if let id = id{
            APIManager.request.delete(url: "/groceries/\(id)") { result in
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

let previewGroceryViewModel = GroceryViewModel(id: 1, name: "Toilet paper", quantity: 1, createdAt: "2024-05-15", creatorName: "Ian")
