
import SwiftUI

struct AddButtonContainerView: View {
    @Binding var clickedAdd : Bool
    
    var body: some View {
        VStack{
            Spacer()
            Button(action: {clickedAdd.toggle()}) {
                VStack{
                    Image(systemName: "plus.circle.fill").resizable().scaledToFit()
                    Text("Add").font(.caption)
                }.frame(width:45)
            }
        }.foregroundColor(.black)
    }
}

#Preview {
    AddButtonContainerView(clickedAdd: .constant(true))
}
