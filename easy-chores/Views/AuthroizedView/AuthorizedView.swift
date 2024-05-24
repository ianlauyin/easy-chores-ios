
import SwiftUI

enum CurrentPage{
    case chore
    case grocery
    case home
    case calendar
    case notice
    case profile
    case createGroup
    case editGroup
}

enum CurrentSlide{
    case none
    case addItem
    case group
}

struct AuthorizedView: View {

    @EnvironmentObject var user : LoginUserViewModel
    @State private var currentPage: CurrentPage = .home
    @State private var currentSlide :CurrentSlide = .none
    

    
    var body: some View {
        VStack(alignment: .center,spacing:0){
            switch currentPage{
            case .home: HomeView(currentSlide:$currentSlide,currentPage:$currentPage)
            case .calendar: VStack{
                Spacer()
                Text("Calendar")
                Spacer()
            }
            case .notice : VStack{
                Spacer()
                Text("notice")
                Spacer()
            }
            case .profile: ProfileView()
            case .grocery: CreateGroceryView{currentPage = .home}
            case .chore: CreateChoreView{currentPage = .home}
            case .createGroup : CreateGroupView{currentPage = .home}
            case .editGroup: EditGroupView()
            }
            AuthroizedTabView(currentPage:$currentPage)
        }.overlay{
            ZStack{
                AddButtonContainerView(currentSlide: $currentSlide,currentPage:$currentPage)
                if currentSlide == .addItem{
                    AddItemSlideView(currentPage: $currentPage, currentSlide: $currentSlide )
                        .transition(.move(edge: .bottom))
                }
                if currentSlide == .group{
                    GroupSlideView(currentPage:$currentPage,currentSlide:$currentSlide)
                        .transition(.move(edge: .bottom))
                }
            }
        }.ignoresSafeArea(.all,edges:.bottom)
    }
}

#Preview {
    AuthorizedView().environmentObject(LoginUserViewModel()).environmentObject(ErrorManager())
}
