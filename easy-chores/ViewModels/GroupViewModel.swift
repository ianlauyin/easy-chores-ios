
import Foundation

class GroupViewModel: ObservableObject {
    @Published var group: GroupModel
    
    init(id: Int, name: String) {
        self.group = GroupModel(id:id, name: name)
        }
}
