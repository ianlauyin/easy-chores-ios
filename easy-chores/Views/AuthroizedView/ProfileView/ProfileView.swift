
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
                    .font(Font.custom("Poppins-Regular",size:18))
                Text(user.username ?? "abc")
                    .foregroundStyle(.customPrimary)
                    .font(Font.custom("Poppins-Regular",size:16))
            }.padding(.horizontal,10)
            VStack(alignment: .leading,spacing:4){
                Text("Email:")
                    .font(Font.custom("Poppins-Regular",size:18))
                Text(KeychainManager.keychain.userEmail ?? "abc@gmail.com")
                    .foregroundStyle(.customPrimary)
                    .font(Font.custom("Poppins-Regular",size:16))
            }.padding(.horizontal,10)
            Spacer()
            LogoutButtonView()
        }.padding(25)
    }
}

