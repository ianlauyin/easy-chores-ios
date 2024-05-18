import SwiftUI

struct LoginView: View {
    private enum Field: Int, CaseIterable {
        case email, password
    }
    @FocusState private var focusedField: Field?
    @EnvironmentObject private var errorManager : ErrorManager
    @EnvironmentObject var user : LoginUserViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10){
                Spacer()
                Image(.logoNoBackground)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Spacer()
                TextField("Email", text:$email)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .email)
                SecureField("Password", text:$password)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .password)
                HStack{
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    NavigationLink(destination: RegisterView()){
                        Text("Sign Up").bold()
                            
                    }.foregroundStyle(.black)
                }.font(.caption)
                    .padding(10)
                Spacer()
                CustomButtonView(width: .infinity, text: "Login"){
                    Task{await handleLogin()}
                }.padding(.vertical,20)
            }.padding()
            .onTapGesture { focusedField = nil}
        }
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
                throw APIError.invalidReponseData
            }
        }catch{
            errorManager.message = error.localizedDescription
        }
    }
}

#Preview {
    LoginView()
}
