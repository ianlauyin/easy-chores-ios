

import SwiftUI

struct MainView: View {
    @StateObject var user = LoginUserViewModel()
    @StateObject var errorManager = ErrorManager()
    
    var body: some View {
        ZStack{
            if user.id == nil{
                LoginView()
            }else{
                AuthorizedView()
            }
            if errorManager.message != nil{
                ErrorView()
            }
        }.environmentObject(user)
            .environmentObject(errorManager)
    }
}

#Preview {
    MainView()
}
