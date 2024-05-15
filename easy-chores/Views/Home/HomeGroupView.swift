import SwiftUI

struct HomeGroupView: View {
    @EnvironmentObject var user : UserModel
    @Binding var currentGroupId : Int?
    @State var groups : [GroupModel] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                user.getUserGroup {
                    result in 
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

#Preview{
    HomeGroupView(currentGroupId: .constant(1))
}
