import SwiftUI

struct GroceryItemView: View {
    @EnvironmentObject private var errorManager : ErrorManager
    let grocery : GroceryViewModel
    let handleRemove : (Int)->Void
    
    var body: some View {
        HStack{
            VStack(alignment:.leading,spacing: 3){
                Text("\(grocery.name ?? "Grocery Name") x \(grocery.quantity ?? 1)")
                    .font(Font.custom("Poppins-Regular",size:16))
                HStack{
                    Text("Created by: \(grocery.creatorName ?? "")")
                        .frame(width:100,alignment:.leading)
                    Text("Date: \(grocery.createdAt ?? "")")
                }.foregroundStyle(.gray)
                    .font(Font.custom("Poppins-Regular",size:10))
                
            }
            Spacer()
            CustomButtonView(width:51, height: 27,text: "Done",fontSize: 10){Task{await removeGrocery()}}
        }.padding(.trailing,5).frame(width:332,height:40)
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


