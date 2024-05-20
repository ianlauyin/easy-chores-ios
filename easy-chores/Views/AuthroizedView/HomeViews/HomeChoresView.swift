

import SwiftUI

struct HomeChoresView: View {
    @ObservedObject var currentGroup : GroupViewModel
    @EnvironmentObject private var errorManager : ErrorManager
    @State var chores : [ChoreViewModel] = []
    
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Chores")
                    .font(.title)
                    .bold()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: true){
                if chores.isEmpty{
                   Text("This Group have no chore yet.")
                }else{
                    HStack(alignment: .top,spacing: 16){
                        ForEach(chores){ chore in
                            ChoreItemView(chore: chore, handleRemove:removeChore)}
                    }.padding(10)
                }
            }.frame(height: 120)
        }.task(id:currentGroup.id){
            await updateChores()}
    }
    
    @MainActor
    func updateChores() async{
        do{
            let chores = try await currentGroup.getGroupChores()
            self.chores = chores
        }catch{
            errorManager.message = "Home Chore View: \(error.localizedDescription)"
        }
    }
    
    func removeChore(choreId:Int){
        if let index = chores.firstIndex(where: { chore in chore.id == choreId }) {
                chores.remove(at: index)
            }
    }
}

