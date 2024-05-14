

import SwiftUI

struct MainView: View {
    @ObservedObject var user : UserViewModel
    
    init(){
        user = UserViewModel(id: 1, username: "Ian")
    }
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            HomeView(user:user).tabItem {  Image(systemName:"house")
                Text("Home")}.tag(1)
            Text("Calendar").tabItem {  Image(systemName:"calendar")
                Text("Home")}.tag(2)
            Text("Add").tabItem { Image(systemName:"plus.circle.fill")
                Text("Add")}.tag(3)
            Text("Notice").tabItem { Image(systemName:"bell")
                Text("Notice")}.tag(4)
            Text("Profile").tabItem {  Image(systemName:"person.crop.circle")
                Text("Home")}.tag(5)
        }.toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    MainView()
}
