
import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text("Let's create your account").font(.title2).bold()
                Spacer()
            }.padding(.vertical,30)
            TextField("User Name", text:$username)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text:$email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text:$password)
                .textFieldStyle(.roundedBorder)
            HStack{
                Text("Already a member?")
                Text("Log in").bold().onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }.font(.caption)
                .padding(20)
            Spacer()
            CustomButtonView(width: .infinity, text: "Sign Up"){
                Task{await handleRegister()}
            }
        }.padding()
        .navigationBarBackButtonHidden()
    }
    @MainActor
    func handleRegister()async{
        do{
            if email.isEmpty || password.isEmpty || username.isEmpty{
                throw APIError.invalidData
            }
            let userData = try await APIManager.request.register(email: email, password: password,username:username)
            if let userId = userData["user_id"] as? Int,
               let username = userData["username"] as? String{
                user.id = userId
                user.username = username
                KeychainManager.keychain.userEmail = email
                KeychainManager.keychain.userPassword = password
            }else{
                throw APIError.invalidData
            }
        }catch{
            errorManager.message = "Login View: \(error.localizedDescription)"
        }
    }
}

#Preview {
    RegisterView()
}
