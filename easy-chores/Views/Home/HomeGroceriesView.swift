

import SwiftUI

struct HomeGroceriesView: View {
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
                VStack{
                    ForEach(groceries){ grocery in
                        GroceryItemView(grocery:grocery,handleRemove:removeGrocery)
                        Divider()
                    }
                }
            }
        }
        .onAppear{
            updateGroceries()
        }.onChange(of: currentGroup.id){
            updateGroceries()
        }
    }
    
    func updateGroceries(){
        currentGroup.getGroupGroceries{
            result in
            switch result{
            case .success(let fetchedGroceries):
                groceries=fetchedGroceries
            case .failure(let error):
                print("Grocery: \(error)")
            }
        }
    }
    
    func removeGrocery(groceryId:Int){
        if let index = groceries.firstIndex(where: { grocery in grocery.id == groceryId }) {
                groceries.remove(at: index)
            }
    }
}

