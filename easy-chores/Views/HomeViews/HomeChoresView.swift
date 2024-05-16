

import SwiftUI

struct HomeChoresView: View {
    @ObservedObject var currentGroup : GroupViewModel
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
                HStack(alignment: .top,spacing: 16){
                    ForEach(chores){ chore in
                        ChoreItemView(chore: chore, handleRemove:removeChore)}
                }.padding(.bottom,15)
            }.frame(height: 120)
        }
        .task(id: currentGroup.id) {
            await updateChores()
        }
    }
    
    @MainActor
    func updateChores() async{
        do{
            let chores = try await currentGroup.getGroupChores()
            self.chores = chores
        }catch{
            print(error)
        }
    }
    
    func removeChore(choreId:Int){
        if let index = chores.firstIndex(where: { chore in chore.id == choreId }) {
                chores.remove(at: index)
            }
    }
}

