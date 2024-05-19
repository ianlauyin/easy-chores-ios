
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    @StateObject private var currentGroup = GroupViewModel()
    @State private var isGroupMenuOpen = false
        
    var body: some View {
        NavigationStack{
            GeometryReader{_ in
                VStack(alignment: .leading){
                    Text("Welcome! \(user.username ?? "user")").font(.title2)
                    if user.id != nil{
                        HStack{
                            GroupListView(currentGroup:currentGroup)
                            MenuButton{
                                isGroupMenuOpen = true
                            }
                        }
                        if currentGroup.id != nil {
                            VStack(spacing:20){
                                HomeChoresView(currentGroup: currentGroup)
                                HomeGroceriesView(currentGroup:currentGroup)
                            }
                        }
                    }else{
                        LoadingView()
                    }
                }.padding(.horizontal,20)
            }.overlay{
                if isGroupMenuOpen{
                    VStack{
                        Color.black.opacity(0.2).ignoresSafeArea(.all)
                        GroupMenuView(){
                            isGroupMenuOpen = false
                        }
                    }
                }
            }
        }
    }
}

