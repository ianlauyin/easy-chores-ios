

import SwiftUI
import DotEnv

struct MainView: View {
    var body: some View {
        AuthorizedView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let user = UserModel(userId: 2)
    static var previews: some View {
        MainView()
            .environmentObject(user)
    }
}
