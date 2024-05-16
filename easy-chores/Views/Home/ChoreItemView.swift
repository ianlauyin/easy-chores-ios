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
                DoneButtonView(width:180).onTapGesture {
                    removeChore()
                }
            }
        }
        .padding(10)
        .frame(width:200,height:120)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 2)
        )
    }
    
    func removeChore(){
        chore.doneChore(completedDate: Date.now){
            result in
            switch result{
            case .success():
                guard let choreId = chore.id else{
                    print("Remove Chore: Invalid id")
                    return
                }
                handleRemove(choreId)
            case .failure(let error):
                print(error)
            }
        }
    }
}
