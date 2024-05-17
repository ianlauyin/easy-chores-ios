
import SwiftUI

enum AddItemPage{
    case chore
    case grocery
    case none
}


struct AuthorizedView: View {
    @StateObject var user = previewUserViewModel
    @State private var openAddPopUp = false
    @State private var addItemPage: AddItemPage = .none
    
    var body: some View {
        if  addItemPage == .none {
            TabView{
                HomeView().tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }.tag(1)
                Text("Calendar").tabItem {
                    Image(systemName:"calendar")
                    Text("Calendar")
                }.tag(2)
                Spacer()
                Text("Notice").tabItem {
                    Image(systemName:"bell")
                    Text("Notice")
                }.tag(4)
                Text("Profile").tabItem {
                    Image(systemName:"person.crop.circle")
                    Text("Profile")
                }.tag(5)
            }.environmentObject(user)
                .toolbarBackground(.visible, for: .tabBar)
                .overlay{
                    AddButtonContainerView(openAddPopUp: $openAddPopUp,
                                           addItemPage: $addItemPage)
                }
        }
        if addItemPage == .chore{
            CreateChoreView(addItemPage:$addItemPage)
        }
        if addItemPage == .grocery{
            Button(action: {addItemPage = .none}){
                Text("Grocery Back")}
        }
    }
}
