import SwiftUI

struct ChoreItemView: View {
    @EnvironmentObject private var errorManager : ErrorManager
    var chore : ChoreViewModel
    let handleRemove : (Int)->Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .shadow(radius: 2, x:2, y:2)
            .frame(width:144 ,height:115)
            .overlay{
                VStack(alignment:.leading,spacing:6){
                    Text(chore.title ?? "Title")
                        .font(Font.custom("Poppins-Regular",size:12))
                        .bold()
                    VStack(alignment:.leading, spacing:2){
                        Text("Assigned to: \(chore.assignedUsers.joined(separator: ", "))")
                        Text("Date: \(chore.createdAt ?? "")")
                            
                    }.font(Font.custom("Poppins-Regular",size:10))
                    CustomButtonView(width:120, height: 27,text:"Done",fontSize: 10)
                    {Task{ await removeChore() }}
                }.padding(12)
            }
    }
    
    @MainActor
    func removeChore()async{
        do{
            _ = try await chore.doneChore(completedDate: Date.now)
            guard let choreId = chore.id else{
                throw CustomDataError.invalidChoreId
            }
            handleRemove(choreId)
        }catch{
            errorManager.error = error
        }
    }
}

#Preview {
    ChoreItemView(chore: previewUnfinshedChoreViewModel){_ in }.environmentObject(ErrorManager())
}
