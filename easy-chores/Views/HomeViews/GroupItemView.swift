
import SwiftUI

struct GroupItemView: View {
    var isSelected : Bool
    var group :GroupViewModel
    var onClick: () -> Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 40)
                .fill(isSelected ? Color.black : Color.white)
                .stroke(Color.black, lineWidth: 2)
                .frame(width:100,height:40)
        }.overlay{
            Text(group.name ?? "Group").font(.headline).foregroundColor(isSelected ? .white : .black)
        }
    }
}
