
import SwiftUI

struct EditGroupView: View {
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject var errorManager : ErrorManager
    @State var email :String = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var memberList : [UserViewModel] = []
    var handleBack : ()->Void
    
    var body: some View {
        VStack(alignment:.leading, spacing:18){
            ZStack{
                Text("Edit group")
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
            Text("")
            GroupListView(currentGroup: currentGroup)
            if currentGroup.id != nil{
                TextField("Add user by email", text : $email).textFieldStyle(.roundedBorder)
                CustomButtonView(width: 339, height: 40, text: "Add"){
                    Task{await handleAdd()}
                }
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
            errorManager.error = error
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
                throw CustomDataError.invalidGroupId
            }
        }catch{
            errorManager.error = error
        }
    }
    
    @MainActor
    func handleDelete(removeUserEmail:String?)async{
        do{
            if let groupId = currentGroup.id,
               let removeUserEmail = removeUserEmail{
                _ = try await APIManager.request.delete(url: "/groups/\(groupId)/users/\(removeUserEmail)")
                await updateUserList()
                if removeUserEmail == KeychainManager.keychain.userEmail{
                    handleBack()
                }
            }else{
                throw CustomDataError.invalidGroupId
            }
        }catch{
            errorManager.error = error
        }
    }
}

