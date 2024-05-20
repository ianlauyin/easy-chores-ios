
import SwiftUI

struct CreateGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State var name :String = ""
    var body: some View {
        VStack{
            TextField("Group name", text : $name).textFieldStyle(.roundedBorder)
            Spacer()
            CustomButtonView(width: .infinity, text: "Create Group"){
                Task{await handleClick()}
            }
        }.padding()
        .navigationBarTitle("Create New Group")
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
            presentationMode.wrappedValue.dismiss()
        }catch{
            errorManager.error = error
        }
    }
}
