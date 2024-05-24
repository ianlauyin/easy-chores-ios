import SwiftUI



struct CreateChoreView: View {
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject private var errorManager : ErrorManager
    @State private var title = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var users : [UserViewModel] = []
    @State var selectedUserId : Int? = nil
    var handleBack : ()->Void
    
    
    var body: some View {
        VStack(spacing:16){
            ZStack{
                Text("Add Chore")
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
            CustomTextFieldView(input: $title, placeholder: "What chores need to be done?")
            GroupListView(currentGroup: currentGroup)
            if !users.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .stroke(selectedUserId == nil ? Color.gray : Color.customPrimary, lineWidth: 1)
                    .frame(width: 339 , height:49)
                    .overlay{
                        HStack{
                            Text("Assign this chore to...")
                                .padding()
                                .foregroundStyle(selectedUserId == nil ? .gray : .black)
                            Spacer()
                            Picker("", selection: $selectedUserId){
                                Text("")
                                    .tag(nil as Int?)
                                ForEach(users , id: \.id) { user in
                                    Text(user.username ?? "Unknown user").tag(user.id)
                                }
                            }.pickerStyle(.menu)
                                .accentColor(.black)
                        }
                    }
            }
            Spacer()
            CustomButtonView(width:339, height: 40, text: "Add",bold:true){
                Task{
                    await createChore()
                }
            }
        }.padding()
        .onTapGesture { hideKeyboard()}
        .task(id:currentGroup.id){
            if currentGroup.id != nil {
                    await updateGroupUser()
                }
        }
    }
    
    @MainActor
    func updateGroupUser() async{
        if currentGroup.id == nil{
            return
        }
        do{
            let users = try await currentGroup.getGroupUsers()
            self.users = users
        }catch{
            errorManager.error = error
        }
    }
    
    @MainActor
    func createChore() async{
        do{
            if let groupId = currentGroup.id{
                let choreData : [String:Any] = [
                    "group_id":groupId,
                    "title":title]
                let jsonChoreData = try await APIManager.request.post(url: "/chores", data: choreData)
                let jsonChoreObject = try JSONSerialization.jsonObject(with: jsonChoreData, options: [])
                guard let chore = jsonChoreObject as? [String: Any] else {
                    throw CustomDataError.invalidJSONForData
                }
                guard let choreId = chore["id"] else{
                    throw APIError.invalidResponseData
                }
                let assignedUserIdData = ["user_ids":[selectedUserId]]
                _ = try await APIManager.request.put(url: "/chores/\(choreId)/users", data: assignedUserIdData)
                handleBack()
            }else{
                throw CustomDataError.error("Please create/join group first.")
            }
        }catch{
            errorManager.error = error
        }
    }
}

