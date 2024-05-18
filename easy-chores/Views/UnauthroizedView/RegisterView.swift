
import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : LoginUserViewModel
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
            TextField("Password", text:$password)
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
        
    }
}

#Preview {
    RegisterView()
}
