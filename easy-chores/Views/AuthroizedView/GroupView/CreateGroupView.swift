
import SwiftUI

struct CreateGroupView: View {
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State var name :String = ""
    var handleBack : ()->Void
    var body: some View {
        VStack(spacing:24){
            ZStack{
                Text("Create new group")
                    .font(Font.custom("Poppins-Regular",size:20))
                    .bold()
                    .foregroundStyle(.customAccent)
                HStack{
                    Button(action:handleBack){
                        Image(systemName:"lessthan")
                            .resizable()
                            .frame(width:7,height:13)
                            .padding(.leading,12)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
            }
            CustomTextFieldView(input: $name, placeholder: "Group name")
            Spacer()
            CustomButtonView(width: 339, height: 40, text: "Create Group",bold: true){
                Task{await handleClick()}
            }
        }.padding()
    }
    
    @MainActor
    func handleClick() async{
        do{
            var requestData : [String:Any] = ["name":name]
            if let userId = user.id {
                requestData["user_id"] = userId
            }else{
                throw CustomDataError.invalidUserId
            }
            _ = try await APIManager.request.post(url: "/groups", data: requestData)
            handleBack()
        }catch{
            errorManager.error = error
        }
    }
}


#Preview {
    CreateGroupView(){}.environmentObject(LoginUserViewModel()).environmentObject(ErrorManager())
}
