import SwiftUI

struct MenuButton: View {
    var onClick : ()->Void
    
    var body: some View {
        Button(action: onClick){
                Image(systemName:"ellipsis")
        }.foregroundStyle(.black)
    }
}
