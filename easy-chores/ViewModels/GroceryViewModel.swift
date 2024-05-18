
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
    
    @MainActor
    func doneGrocery() async throws ->Void{
        if let id = id{
            do {
                _ = try await APIManager.request.delete(url: "/chores/\(id)")
                return
            } catch {
                throw error
            }
        }else{
            throw APIError.invalidData
        }
    }
}

let previewGroceryViewModel = GroceryViewModel(id: 1, name: "Toilet paper", quantity: 1, createdAt: "2024-05-15", creatorName: "Ian")
