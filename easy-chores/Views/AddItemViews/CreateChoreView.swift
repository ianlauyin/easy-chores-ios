import SwiftUI



struct CreateChoreView: View {
    private enum Field: Int, CaseIterable {
            case title, detail
        }
    @FocusState private var focusedField: Field?
    
    @EnvironmentObject var user : UserViewModel
    @Binding var addItemPage : AddItemPage
    @State private var title = ""
    @State private var detail = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var users : [UserViewModel] = []
    @State var selectedUserId : Int? = nil
    
    
    var body: some View {
        VStack(spacing:30){
            HStack {
                Button(action: {
                    addItemPage = .none
                    focusedField = nil
                }) {
                    Image(systemName: "lessthan")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(height: 20)
                }.frame(width:20)
                Spacer()
                Text("Add Chore")
                    .font(.title)
                Spacer()
                Spacer()
                    .frame(width:20)
            }
            TextField("What chores need to be done?",text:$title)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .title)
            GroupListView(currentGroup: currentGroup)
            if !users.isEmpty {
                Picker("Assign this chore to...", selection: $selectedUserId){
                    Text("Select a user")
                        .tag(nil as Int?)
                    ForEach(users , id: \.id) { user in
                        Text(user.username ?? "Unknown user").tag(user.id)
                    }
                }
            }
            VStack(alignment: .leading){
                Text("Detail:")
                TextEditor(text:$detail)
                    .border(.gray)
                    .focused($focusedField, equals: .detail)
                }
            Spacer()
            CustomButtonView(width: .infinity, text: "Add"){
                Task{
                    focusedField = nil
                    await createChore()
                    addItemPage = .none
                }
            }
        }.padding()
        .onTapGesture { focusedField = nil}
        .task(id:currentGroup.id){
            if currentGroup.id != nil{
                await updateGroupUser()
            }
        }
    }
    
    @MainActor
    func updateGroupUser() async{
        do{
            let users = try await currentGroup.getGroupUsers()
            self.users = users
        }catch{
            print(error)
        }
    }
    
    @MainActor
    func createChore() async{
        if let groupId = currentGroup.id{
            do{
                let choreData : [String:Any] = [
                    "group_id":groupId,
                    "title":title,
                    "detail":detail]
                guard let jsonChoreData = try await APIManager.request.post(url: "/chores", data: choreData)else {
                    throw APIError.invalidReponseData  }
                let jsonChoreObject = try JSONSerialization.jsonObject(with: jsonChoreData, options: [])
                guard let chore = jsonChoreObject as? [String: Any] else {
                    throw APIError.invalidReponseData
                }
                guard let choreId = chore["id"] else{
                    throw APIError.invalidReponseData
                }
                let assignedUserIdData = ["user_ids":[selectedUserId]]
                _ = try await APIManager.request.put(url: "/chores/\(choreId)/users", data: assignedUserIdData)
            }catch{
                print(error)
            }
        }else{
            print(APIError.invalidData)
        }
    }
}

#Preview {
    CreateChoreView(addItemPage: .constant(.chore)).environmentObject(previewUserViewModel)
}
