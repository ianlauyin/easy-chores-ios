
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user : LoginUserViewModel
    var body: some View {
        VStack(alignment:.leading,spacing: 18){
            HStack{
                Spacer()
                Text("Profile")
                    .font(Font.custom("Poppins-Regular",size:20))
                    .foregroundStyle(.customAccent)
                    .bold()
                Spacer()
            }.padding(15)
            VStack(alignment: .leading,spacing:4){
                Text("User Name:")
                Text(user.username ?? "abc").foregroundStyle(.customPrimary)
            }.padding(.horizontal,10)
            VStack(alignment: .leading,spacing:4){
                Text("Email:")
                Text(KeychainManager.keychain.userEmail ?? "abc@gmail.com").foregroundStyle(.customPrimary)
            }.padding(.horizontal,10)
            Spacer()
            LogoutButtonView()
        }.padding(25)
    }
}

#Preview {
    ProfileView().environmentObject(LoginUserViewModel()).environment(\.font, Font.custom("Poppins-Regular",size:14))
}
