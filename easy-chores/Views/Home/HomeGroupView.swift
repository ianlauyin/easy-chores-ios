import SwiftUI

struct HomeGroupView: View {
    @EnvironmentObject var user : UserViewModel
    @Binding var currentGroupId : Int?
    @State var groups : [GroupModel] = []
    
    var body: some View {
        HStack{
            ForEach(groups) { group in
                GroupListItemView(selected:true, group: group)
            }
        }.onAppear {
            user.getUserGroup{result in
                switch result {
                case .success(let fetchedGroups):
                    groups = fetchedGroups
                case .failure(let error):
                print(error)
                groups = []
                }
            }
        }
    }
}

