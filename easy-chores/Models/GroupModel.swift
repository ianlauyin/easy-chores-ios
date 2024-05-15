
import Foundation


class GroupModel {
    var id: Int? = nil
    var name:String? = nil
    
    init(id:Int?,name:String?){
        self.id=id
        self.name=name
    }
    
}

struct GroupDataDecorder:Codable{
    let id: Int
    let name:String
}
