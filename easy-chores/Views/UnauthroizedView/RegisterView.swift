
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
                    .foregroundStyle(.customAccent)
                Spacer()
            }.padding(.vertical,30)
            CustomTextFieldView(input: $username, placeholder: "User Name")
            CustomTextFieldView(input: $email, placeholder: "Email")
            CustomTextFieldView(input: $password, placeholder: "Password",secure: true)
            HStack{
                Text("Already a member?").foregroundStyle(.gray)
                Text("Log in").foregroundStyle(.customPrimary).onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding(20)
            Spacer()
            CustomButtonView(width: 340, height: 48, text: "Sign Up",bold:true){
                Task{await handleRegister()}
            }
        }.padding(25)
        .navigationBarBackButtonHidden()
    }
    @MainActor
    func handleRegister()async{
        do{
            if email.isEmpty || password.isEmpty || username.isEmpty{
                throw CustomDataError.invalidInputdata
            }
            let userData = try await APIManager.request.register(email: email, password: password,username:username)
            if let userId = userData["user_id"] as? Int,
               let username = userData["username"] as? String{
                user.id = userId
                user.username = username
                KeychainManager.keychain.userEmail = email
                KeychainManager.keychain.userPassword = password
            }else{
                throw APIError.invalidResponseData
            }
        }catch{
            errorManager.error = error
        }
    }
}

#Preview {
    RegisterView().environment(\.font, Font.custom("Poppins-Regular",size:14))
}
