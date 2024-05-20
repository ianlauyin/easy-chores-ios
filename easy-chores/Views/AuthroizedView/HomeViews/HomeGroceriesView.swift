

import SwiftUI

struct HomeGroceriesView: View {
    @EnvironmentObject private var errorManager : ErrorManager
    @ObservedObject var currentGroup : GroupViewModel
    @State var groceries : [GroceryViewModel] = []
    
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("Groceries")
                    .font(.title)
                    .bold()
                Spacer()
                
            }
            ScrollView(.vertical, showsIndicators: true){
                if groceries.isEmpty {
                   Text("This Group have no grocery yet.")
                }else{
                    VStack{
                        ForEach(groceries){ grocery in
                            GroceryItemView(grocery:grocery,handleRemove:removeGrocery)
                            Divider()
                        }
                    }
                }
            }
        }
        .task(id: currentGroup.id) {
            await updateGroceries()
        }
    }
    
    @MainActor
    func updateGroceries() async{
        do{
            let groceries = try await currentGroup.getGroupGroceries()
            self.groceries = groceries
        }catch{
            errorManager.error = error
        }
    }
    
    func removeGrocery(groceryId:Int){
        if let index = groceries.firstIndex(where: { grocery in grocery.id == groceryId }) {
                groceries.remove(at: index)
            }
    }
}

