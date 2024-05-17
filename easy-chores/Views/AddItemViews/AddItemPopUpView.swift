
import SwiftUI

struct AddItemPopUpView: View {
    let text : String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.blue)
            .frame(width:160, height:100)
            .overlay{
                VStack{
                    Text(text).font(.headline)
                    Image(systemName: "plus").resizable().scaledToFit()
                }.padding(20)
            }
    }
}

#Preview {
    AddItemPopUpView(text:"Add Groceries")
}
