
import SwiftUI

enum CurrentPage{
    case chore
    case grocery
    case home
    case calendar
    case notice
    case profile
}

struct AuthorizedView: View {

    @EnvironmentObject var user : LoginUserViewModel
    @State private var currentPage: CurrentPage = .home
    

    
    var body: some View {
        VStack(alignment: .center){
            switch currentPage{
            case .home: HomeView()
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
            case .chore: CreateChoreView()
            case .grocery: CreateGroceryView()
            }
            AuthroizedTabView(currentPage:$currentPage)
        }.overlay{
            VStack{
                Spacer()
                AddButtonContainerView(currentPage:$currentPage)
                    .padding(.bottom,55)
            }
        }
        .ignoresSafeArea(.all,edges: .bottom)
    }
}

