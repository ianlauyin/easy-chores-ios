
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    @StateObject private var currentGroup = GroupViewModel()
    @Binding var currentSlide : CurrentSlide
    @Binding var currentPage : CurrentPage
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            Text("Welcome! \(user.username ?? "user")").font(Font.custom("Poppins-Regular",size:16))
                .bold()
                .foregroundStyle(.customAccent)
            if user.id != nil{
                HStack{
                    GroupListView(currentGroup:currentGroup)
                    if currentGroup.id != nil {
                        MenuButton{
                            currentSlide = .group
                        }
                    }else{
                        Button("Create"){
                            currentPage = .createGroup
                        }
                    }
                }
                if currentGroup.id != nil {
                    VStack(spacing:20){
                        HomeChoresView(currentGroup: currentGroup)
                        HomeGroceriesView(currentGroup:currentGroup)
                    }
                }
                Spacer()
            }else{
                LoadingView()
            }
        }.padding(25)
    }
}
