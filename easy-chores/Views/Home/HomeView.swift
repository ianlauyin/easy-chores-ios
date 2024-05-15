
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user : UserViewModel
    @State var currentGroupId : Int?
    @State private var currentGroup : GroupViewModel? = nil
    
        
    var body: some View {
        VStack{
            Text("Welcome! \(user.username ?? "user")")
            HomeGroupView(currentGroupId:$currentGroupId).onChange(of: currentGroupId){
                guard let currentGroupId = currentGroupId else{
                    print("Error on currentGroupId changed")
                    return}
                currentGroup = GroupViewModel(groupId: currentGroupId)
                print(currentGroup?.id ?? "0")
            }
        }
    }
}


#Preview {
    HomeView()
}
