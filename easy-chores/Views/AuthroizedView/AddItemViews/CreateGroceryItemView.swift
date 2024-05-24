import SwiftUI


struct CreateGroceryItemView: View {
    @Binding var grocery:newGrocery
    @State var quantity : String = ""
    @EnvironmentObject var errorManager : ErrorManager
    var onClick :()->Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .stroke(.gray)
            .frame(height:80)
            .overlay{
                HStack{
                    TextField("Grocery name",text:$grocery.name)
                        .padding()
                    Text("x")
                    TextField("1",text: $quantity)
                        .keyboardType(.decimalPad)
                        .frame(width:50)
                    Button(action:onClick){
                        Image(systemName:"minus.square")
                            .resizable().scaledToFit()
                    }.padding()
                        .foregroundStyle(.red)
                        .frame(width:50,height:50)
                }.onChange(of: quantity){
                    handleQuantityChange()
                }
            }
    }
    func handleQuantityChange(){
        if quantity.count == 0{
            grocery.quantity = 1
            return
        }
        if let quantity = Int(quantity){
            grocery.quantity = quantity
        }else{
            errorManager.error = CustomDataError.error("Quantity must be number.")
        }
    }
}
