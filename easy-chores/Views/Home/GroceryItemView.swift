import SwiftUI

struct GroceryItemView: View {
    let grocery : GroceryViewModel
    let handleRemove : (Int)->Void
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("\(grocery.name ?? "Grocery Name") x \(grocery.quantity ?? 1)").font(.headline)
                HStack{
                    Text("Created by: \(grocery.creatorName ?? "")").font(.caption2).foregroundStyle(.gray)
                        .frame(width:100, alignment: .leading)
                    Text("Date: \(grocery.createdAt ?? "")").font(.caption2).foregroundStyle(.gray)
                }
            }
            Spacer()
            DoneButtonView(width:60).onTapGesture {
                removeGrocery()
            }
        }.padding(.trailing,20).frame(height:40)
    }
    
    func removeGrocery(){
        grocery.doneGrocery{
            result in
            switch result{
            case .success():
                guard let groceryId = grocery.id else{
                    print("Remove Grocery: Invalid id")
                    return
                }
                handleRemove(groceryId)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


