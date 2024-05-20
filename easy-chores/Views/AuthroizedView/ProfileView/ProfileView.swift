
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user : LoginUserViewModel
    var body: some View {
        VStack{
            Text("Profile:")
            HStack{
                Text("User Name:")
                Text(user.username ?? "")
            }
            HStack{
                Text("User Email:")
                Text(KeychainManager.keychain.userEmail ?? "")
            }
            LogoutButtonView()
            Spacer()
        }
    }
}

