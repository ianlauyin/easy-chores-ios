
import SwiftUI

struct EditGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Button(action:{presentationMode.wrappedValue.dismiss()}){
                Text("return")
            }
        }
    }
}

#Preview {
    EditGroupView()
}
