
import SwiftUI

struct AddItemView: View {
    let text : String
    let image : String
    let onClick : ()->Void
    
    var body: some View {
        Button(action:onClick){
            RoundedRectangle(cornerRadius: 20)
                .fill(.customSecondary)
                .frame(width:138, height:97)
                .overlay{
                    VStack(spacing:12){
                        Image(systemName: image).resizable()
                            .scaledToFit()
                            .frame(width: 36,height:36)
                        Text(text)
                    }.padding(14)
                }
        }.foregroundStyle(.black)
    }
}

#Preview {
    AddItemView(text: "Add Chores", image:"plus"){()}.environment(\.font, Font.custom("Poppins-Regular",size:14))
}
