
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    @StateObject private var currentGroup = GroupViewModel()
        
    var body: some View {
        GeometryReader{_ in
            VStack(alignment: .leading){
                Text("Welcome! \(user.username ?? "user")").font(.title2)
                GroupListView(currentGroup:currentGroup)
                if currentGroup.id != nil {
                    VStack(spacing:20){
                        HomeChoresView(currentGroup: currentGroup)
                        HomeGroceriesView(currentGroup:currentGroup)
                    }
                }else{
                    LoadingView()
                }
            }.padding(.horizontal,20)
        }.onAppear{print(user.id ?? "no id")}
    }
}
