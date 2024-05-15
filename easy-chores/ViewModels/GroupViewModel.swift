
import Foundation

class GroupViewModel:ObservableObject {
    @Published private var groupModel : GroupModel
    var id: Int {return groupModel.id}
    var groupName: String? {return groupModel.name}
    
    init(groupId:Int,name:String?){
        self.groupModel = GroupModel(id: groupId, name: name)
    }
    
}

let previewGroupViewModel = GroupViewModel(groupId: 1, name: "Group1")
