import SwiftUI

struct GroupListView: View {
    @EnvironmentObject var user : UserViewModel
    @ObservedObject var currentGroup : GroupViewModel
    @State var groups : [GroupViewModel] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(groups) { group in
                    GroupItemView(isSelected: currentGroup.id == group.id, group: group){currentGroup.id = group.id}
                }
            }.padding(5)
        }.task {
            await fetchGroups()
        }
    }
    
    @MainActor
    func fetchGroups() async {
        do {
            let fetchedGroups = try await user.getUserGroup()
            groups = fetchedGroups
            currentGroup.id = fetchedGroups.first?.id
        } catch {
            print(error)
        }
    }
}

