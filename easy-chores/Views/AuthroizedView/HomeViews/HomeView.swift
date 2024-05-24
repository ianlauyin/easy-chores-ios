
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    @StateObject private var currentGroup = GroupViewModel()
    @Binding var currentSlide :CurrentSlide
        
    var body: some View {
        NavigationStack{
            GeometryReader{_ in
                VStack(alignment: .leading){
                    Text("Welcome! \(user.username ?? "user")").font(.title2)
                    if user.id != nil{
                        HStack{
                            GroupListView(currentGroup:currentGroup)
                            if currentGroup.id != nil {
                                MenuButton{
                                    currentSlide = .group
                                }
                            }else{
                                NavigationLink(destination: CreateGroupView()){
                                    Text("Create Group")
                                }
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
            }
        }
    }
}



