
import Foundation

struct GroupModel:Codable,Identifiable{
    let id: Int
    var name:String? = nil
}

let previewGroup = GroupModel(id:1, name: "Group1")
