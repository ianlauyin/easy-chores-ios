
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user : LoginUserViewModel
    var body: some View {
        VStack(alignment:.leading,spacing: 20){
            HStack{
                Spacer()
                Text("Profile")
                    .font(.system(size: 20))
                    .foregroundStyle(.customAccent)
                    .bold()
                Spacer()
            }.padding()
            VStack(alignment: .leading){
                Text("User Name:")
                Text(user.username ?? "abc").foregroundStyle(.customPrimary)
            }.padding(.horizontal,10)
            VStack(alignment: .leading){
                Text("Email:")
                Text(KeychainManager.keychain.userEmail ?? "abc@gmail.com").foregroundStyle(.customPrimary)
            }.padding(.horizontal,10)
            Spacer()
            LogoutButtonView()
        }.padding(25)
    }
}

#Preview {
    ProfileView().environmentObject(previewLoginUserViewModel).environment(\.font, Font.custom("Poppins-Regular",size:14))
}
