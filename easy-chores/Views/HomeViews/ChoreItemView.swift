import SwiftUI

struct ChoreItemView: View {
    var chore : ChoreViewModel
    let handleRemove : (Int)->Void
    
    var body: some View {
        ZStack{
            VStack(alignment:.leading,spacing:5){
                Text(chore.title ?? "Title").font(.title3).bold()
                Text("Assigned to: \(chore.assignedUsers.joined(separator: ", "))").font(.caption)
                Text("Date: \(chore.createdAt ?? "")").font(.caption2).foregroundStyle(.gray)
                DoneButtonView(width:180){Task{ await removeChore() }}
            }
        }
        .padding(10)
        .frame(width:200,height:120)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 2)
        )
    }
    
    @MainActor
    func removeChore()async{
        do{
            _ = try await chore.doneChore(completedDate: Date.now)
            guard let choreId = chore.id else{
                throw CustomError.invalidChoreId
            }
            handleRemove(choreId)
        }catch{
            print(error)
        }
    }
}
