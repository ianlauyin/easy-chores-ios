
import Foundation


struct GroceryModel: Identifiable {
    let id: Int
    let name: String
    let quantity:Int
    let createdAt:Date
    let creatorId:Int?
    let groupId:Int?
    let detail:String?
    
    init(id: Int, name: String, quantity:Int, createdAt:Date, creatorId:Int? = nil, groupId:Int? = nil, detail: String? = nil) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.createdAt = createdAt
        self.creatorId = creatorId
        self.groupId = groupId
        self.detail = detail
        }
}
