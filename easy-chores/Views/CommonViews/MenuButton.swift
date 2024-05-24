import SwiftUI

struct MenuButton: View {
    var onClick : ()->Void
    
    var body: some View {
        Button(action: {withAnimation{onClick()}}){
            Image(systemName:"ellipsis")
                .rotationEffect(.degrees(90))
        }.foregroundStyle(.black)
    }
}

#Preview {
    MenuButton{}
}
