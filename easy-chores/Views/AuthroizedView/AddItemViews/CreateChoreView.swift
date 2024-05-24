import SwiftUI



struct CreateChoreView: View {
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject private var errorManager : ErrorManager
    @State private var title = ""
    @State private var detail = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var users : [UserViewModel] = []
    @State var selectedUserId : Int? = nil
    var handleBack : ()->Void
    
    
    var body: some View {
        VStack(spacing:15){
            HStack {
                Spacer()
                Text("Add Chore")
                    .font(.title)
                Spacer()
                Spacer()
                    .frame(width:20)
            }
            TextField("What chores need to be done?",text:$title)
                .textFieldStyle(.roundedBorder)
            GroupListView(currentGroup: currentGroup)
            if !users.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width:.infinity,height:40)
                    .overlay{
                        HStack{
                            Text("Assign this chore to...")
                                .padding()
                            Spacer()
                            Picker("", selection: $selectedUserId){
                                Text("Select a user")
                                    .tag(nil as Int?)
                                ForEach(users , id: \.id) { user in
                                    Text(user.username ?? "Unknown user").tag(user.id)
                                }
                            }.pickerStyle(.menu)
                                .accentColor(.black)
                        }
                    }
            }
            VStack(alignment: .leading){
                Text("Detail:")
                TextEditor(text:$detail)
                    .border(.gray)
                }
            Spacer()
            CustomButtonView(width: .infinity, height: 40, text: "Add"){
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
                    "title":title,
                    "detail":detail]
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
                throw CustomDataError.invalidGroupId
            }
        }catch{
            errorManager.error = error
        }
    }
}

