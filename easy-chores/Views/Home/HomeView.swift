
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user : UserViewModel
    @State var currentGroupId : Int?

    var body: some View {
        VStack{
            Text("Welcome! \(user.username ?? "user")")
            HomeGroupView(currentGroupId:$currentGroupId)
        }
    }
}


#Preview {
    HomeView()
}
