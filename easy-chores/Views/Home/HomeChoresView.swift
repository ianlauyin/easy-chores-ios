

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
        .onAppear{
            updateChores()
        }.onChange(of: currentGroup.id){
            updateChores()
        }
    }
    
    func updateChores(){
        currentGroup.getGroupChores{
            result in
            switch result{
            case .success(let fetchedChores):
                chores=fetchedChores
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeChore(choreId:Int){
        if let index = chores.firstIndex(where: { chore in chore.id == choreId }) {
                chores.remove(at: index)
            }
    }
}

