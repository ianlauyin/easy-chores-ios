
import SwiftUI

struct GroupItemView: View {
    var isSelected : Bool
    var group :GroupModel
    var body: some View {
        ZStack{
            Capsule()
                .fill(isSelected ? Color.black : Color.white)
                .stroke(Color.black, lineWidth: 2)
            Text(group.name ?? "Group").font(.headline).foregroundColor(isSelected ? .white : .black)
        }.frame(width:100, height: 40)
    }
}


#Preview {
    GroupItemView(isSelected:true, group:previewGroup)
}
