import SwiftUI

struct HomeGroupView: View {
    @EnvironmentObject var user : UserViewModel
    @Binding var currentGroupId : Int?
    @State var groups : [GroupModel] = []
    
    var body: some View {
        HStack{
            ForEach(groups) { group in
                GroupListItemView(isSelected: currentGroupId == group.id, group: group)
                    .onTapGesture {
                        currentGroupId = group.id
                    }
            }
        }.onAppear {
            user.getUserGroup{result in
                switch result {
                case .success(let fetchedGroups):
                    groups = fetchedGroups
                    currentGroupId = groups.first?.id
                case .failure(let error):
                print(error)
                groups = []
                }
            }
        }
    }
}

