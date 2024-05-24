import SwiftUI


struct newGrocery:Identifiable{
    var id: Int
    var name:String
    var quantity:Int
}


struct CreateGroceryView: View {
    @EnvironmentObject var user : LoginUserViewModel
    @EnvironmentObject private var errorManager : ErrorManager
    @State private var name = ""
    @State private var detail = ""
    @StateObject var currentGroup = GroupViewModel()
    @State var IdCount = 2
    @State var groceries : [newGrocery] = [newGrocery(id: 1, name: "", quantity: 1)]
    var handleBack : ()->Void
    
    
    var body: some View {
        VStack(spacing:15){
            HStack {
                Spacer()
                Text("Add Grocery")
                    .font(.title)
                Spacer()
                Spacer()
                    .frame(width:20)
            }
            GroupListView(currentGroup: currentGroup)
            ScrollView(.vertical){
                VStack(spacing: 20){
                        ForEach($groceries) { grocery in
                            CreateGroceryItemView(grocery:grocery){
                                removeNewGrocery(grocery.id)
                            }
                        }
                    
                    Button(action: addItem){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .stroke(.gray,style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height:60)
                            .overlay{
                                Text("Add More +")
                                    .foregroundStyle(.black)
                            }
                    }
                }.padding()
            }
            CustomButtonView(width: .infinity, height: 40, text: "Add"){
                hideKeyboard()
                Task{
                    await createGroceries()
                    }
            }
        }.padding()
            .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    func addItem(){
        groceries.append(newGrocery(id: IdCount, name: "", quantity: 1))
        IdCount+=1
    }
    
    @MainActor
    func createGroceries() async{
        do{
            if let groupId = currentGroup.id{
                if let userId = user.id{
                    var groceryData : [String:Any] = [
                        "group_id":groupId,
                        "user_id":userId]
                    for grocery in groceries{
                        groceryData["name"]=grocery.name
                        groceryData["quantity"]=grocery.quantity
                        _ = try await APIManager.request.post(url: "/groceries", data: groceryData)
                        handleBack()
                    }
                }else{
                    throw CustomDataError.invalidUserId
                }
            }else{
                throw CustomDataError.invalidGroupId
            }
        }catch{
            errorManager.error = error
        }
    }
    
    func removeNewGrocery(_ groceryId:Int){
        if let index = groceries.firstIndex(where: { grocery in grocery.id == groceryId }) {
                groceries.remove(at: index)
            }
    }
}

