
import SwiftUI

struct CreateGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State var name :String = ""
    var handleBack : ()->Void
    var body: some View {
        VStack{
            TextField("Group name", text : $name).textFieldStyle(.roundedBorder)
            Spacer()
            CustomButtonView(width: .infinity, height: 40, text: "Create Group"){
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
