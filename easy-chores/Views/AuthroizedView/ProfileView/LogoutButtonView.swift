import SwiftUI

struct LogoutButtonView: View {
    @EnvironmentObject private var user : LoginUserViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.white)
            .stroke(Color.customPrimary,lineWidth:1)
            .frame(width: 340,height: 48)
            .overlay{
                Button(action:{logout()}){
                    Text("Logout")
                        .foregroundStyle(.customPrimary)
                }
            }
    }
    
    func logout(){
        user.id = nil
        user.username = nil
        KeychainManager.keychain.removeAllKeys()
    }
}

