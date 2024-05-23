import SwiftUI

struct GroceryItemView: View {
    @EnvironmentObject private var errorManager : ErrorManager
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
            CustomButtonView(width:60, height: 40,text: "Done"){Task{await removeGrocery()}}
        }.padding(.trailing,20).frame(height:40)
    }
    
    @MainActor
    func removeGrocery()async{
        do{
            _ = try await grocery.doneGrocery()
            guard let groceryId = grocery.id else{
                throw CustomDataError.invalidGroceryId
            }
            handleRemove(groceryId)
        }catch{
            errorManager.error = error
        }
    }
}


