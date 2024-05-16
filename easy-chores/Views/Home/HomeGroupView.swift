import SwiftUI

struct HomeGroupView: View {
    @EnvironmentObject var user : UserViewModel
    @ObservedObject var currentGroup : GroupViewModel
    @State var groups : [GroupViewModel] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(groups) { group in
                    GroupItemView(isSelected: currentGroup.id == group.id, group: group)
                        .onTapGesture {
                            currentGroup.id = group.id
                        }
                }
            }.padding(5)
        }.onAppear {
            user.getUserGroup{result in
                switch result {
                case .success(let fetchedGroups):
                    groups = fetchedGroups
                    currentGroup.id = groups.first?.id
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

