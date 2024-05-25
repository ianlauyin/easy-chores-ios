import SwiftUI


struct CreateGroceryItemView: View {
    @Binding var grocery:newGrocery
    @State var quantity : String = ""
    @EnvironmentObject var errorManager : ErrorManager
    var onClick :()->Void
    
    var body: some View {
        HStack(spacing:12){
            CustomTextFieldView(input: $grocery.name, placeholder:"Grocery",width:200)
            Text("x")
            CustomTextFieldView(input: $quantity, placeholder: "1",width: 50)
                .keyboardType(.decimalPad)
                .onChange(of: quantity){
                    handleQuantityChange()
                }
            Spacer()
            Button(action:onClick){
                Image(systemName:"minus.square")
                    .resizable().scaledToFit()
                    .foregroundStyle(.red)
                    .frame(width:30,height:30)
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
