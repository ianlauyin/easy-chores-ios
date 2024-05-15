
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user : UserModel
    @State var currentGroupId : Int?

    var body: some View {
        VStack{
            Text("Welcome! \(user.username ?? "")")
            HomeGroupView(currentGroupId:$currentGroupId)
        }
    }
}


#Preview {
    HomeView()
}
