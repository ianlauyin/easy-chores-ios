
import SwiftUI

struct GroupItemView: View {
    var isSelected : Bool
    var group :GroupViewModel
    var onClick: () -> Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.customAccent : Color.white)
                .stroke(Color.customAccent, lineWidth: 1)
                .frame(width:77,height:29)
        }.overlay{
            Text(group.name ?? "Group")
            Text(group.name ?? "Group")
                .foregroundColor(isSelected ? .white : .customAccent)
        }
    }
}
