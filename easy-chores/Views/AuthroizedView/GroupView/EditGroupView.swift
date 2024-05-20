
import SwiftUI

struct EditGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State var email :String = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var memberList : [UserViewModel] = []
    
    
    var body: some View {
        VStack{
            GroupListView(currentGroup: currentGroup)
            TextField("Add user by email", text : $email).textFieldStyle(.roundedBorder)
            CustomButtonView(width: .infinity, text: "Add"){
                Task{await handleAdd()}
            }
            VStack(alignment:.trailing){
                Text("Group Members:")
                ForEach(memberList){member in
                    GroupUserView(user:member){
                        Task{await handleDelete(removeUserEmail: member.email)}
                    }
                }
            }
            Spacer()
        }.padding()
            .navigationBarTitle("Create New Group")
        .task(id:currentGroup.id){
            if currentGroup.id != nil{
                await updateUserList()
            }
        }
    }
    
    @MainActor
    func updateUserList()async{
        do{
            let users = try await currentGroup.getGroupUsers()
            memberList = users
        }catch{
            errorManager.message = error.localizedDescription
        }
    }
    
    @MainActor
    func handleAdd()async{
        do{
            if let groupId = currentGroup.id {
                _ = try await APIManager.request.post(url: "/groups/\(groupId)/users/\(email)",data:[:])
                await updateUserList()
                email = ""
            }
            else{
                throw APIError.invalidData
            }
        }catch{
            errorManager.message = error.localizedDescription
        }
    }
    
    @MainActor
    func handleDelete(removeUserEmail:String?)async{
        do{
            if let groupId = currentGroup.id,
            let removeUserEmail = removeUserEmail{
                _ = try await APIManager.request.delete(url: "/groups/\(groupId)/users/\(removeUserEmail)")
                await updateUserList()
            }
            else{
                throw APIError.invalidData
            }
        }catch{
            errorManager.message = error.localizedDescription
        }
    }
}

#Preview {
    EditGroupView()
}
