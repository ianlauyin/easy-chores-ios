

import Foundation


struct ChoreModel: Identifiable {
    let id: Int
    let title: String
    let createdAt:Date
    let groupId:Int?
    let detail:String?
    let completedDate:Date?
    
    init(id: Int, title: String, createdAt:Date,  groupId:Int? = nil, detail: String? = nil, completedDate:Date? = nil) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.groupId = groupId
        self.detail = detail
        self.completedDate = completedDate
        }
}
