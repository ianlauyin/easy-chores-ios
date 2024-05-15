
import SwiftUI

struct GroupListItemView: View {
    @State var selected :Bool
    var group :GroupModel
    var body: some View {
        ZStack{
            Capsule()
                .fill(selected ? Color.black : Color.white)
            Text(group.name ?? "Group").font(.headline).foregroundColor(selected ? .white : .black)
        }.frame(width:100, height: 40)
    }
}


#Preview {
    GroupListItemView(selected:true, group:previewGroup)
}
