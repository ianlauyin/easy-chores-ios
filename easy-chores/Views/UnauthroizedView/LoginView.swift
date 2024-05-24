import SwiftUI


struct LoginView: View {
    @EnvironmentObject private var errorManager : ErrorManager
    @EnvironmentObject var user : LoginUserViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10){
                Spacer()
                Image(.easychoresLogo)
                Spacer()
                CustomTextFieldView(input: $email, placeholder: "Email")
                CustomTextFieldView(input: $password, placeholder: "Password",secure: true)
                Spacer()
                HStack{
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    NavigationLink(destination: RegisterView()){
                        Text("Sign Up")
                    }.foregroundStyle(.customPrimary)
                }.padding(10)
                Spacer()
                CustomButtonView(width: 340,height:48, text: "Login",bold: true){
                    Task{await handleLogin()}
                }.padding(.vertical,20)
            }.padding(25)
        }.onTapGesture {hideKeyboard()}
    }
    
    @MainActor
    func handleLogin() async{
        do{
            let userData = try await APIManager.request.login(email: email, password: password)
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
    LoginView()
}
