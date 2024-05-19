import SwiftUI

struct LogoutButtonView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    
    var body: some View {
        Button(action:{logout()}){
            Text("Logout")
        }
    }
    
    func logout(){
        user.id = nil
        user.username = nil
        KeychainManager.keychain.removeAllKeys()
    }
}

#Preview {
    LogoutButtonView()
}
