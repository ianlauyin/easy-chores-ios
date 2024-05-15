
import SwiftUI

struct AuthorizedView: View {
    @StateObject var user = UserModel(userId:2)
    
    var body: some View {
        TabView{
            HomeView().tabItem {  Image(systemName:"house")
                Text("Home")}.tag(1)
            Text("Calendar").tabItem {  Image(systemName:"calendar")
                Text("Calendar")}.tag(2)
            Text("Add").tabItem { Image(systemName:"plus.circle.fill")
                Text("Add")}.tag(3)
            Text("Notice").tabItem { Image(systemName:"bell")
                Text("Notice")}.tag(4)
            Text("Profile").tabItem {  Image(systemName:"person.crop.circle")
                Text("Profile")}.tag(5)
        }.toolbarBackground(.visible, for: .tabBar).environmentObject(user)
    }
}

#Preview {
    AuthorizedView()
}
