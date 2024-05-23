

import SwiftUI

struct MainView: View {
    @StateObject private var user = LoginUserViewModel()
    @StateObject private var errorManager = ErrorManager()
    
    var body: some View {
        ZStack {
            if user.id != nil {
                AuthorizedView()
            } else {
                LoginView()
            }
            if errorManager.error != nil{
                ErrorView()
            }
        }.environmentObject(user)
        .environmentObject(errorManager)
    }
}

#Preview {
    MainView().environment(\.font, Font.custom("Poppins-Regular",size:14))
}
