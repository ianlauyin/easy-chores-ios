import SwiftUI


struct CreateGroceryItemView: View {
    @Binding var grocery:newGrocery
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
                    Picker("",selection: $grocery.quantity){
                        ForEach(1...50, id:\.self){ num in
                            Text("x\(num)").tag(num)
                        }
                    }.pickerStyle(.inline)
                        .frame(width:80)
                    Button(action:onClick){
                        Image(systemName:"minus.square")
                            .resizable().scaledToFit()
                    }.padding()
                        .foregroundStyle(.red)
                        .frame(width:50,height:50)
                }
            }
    }
}
