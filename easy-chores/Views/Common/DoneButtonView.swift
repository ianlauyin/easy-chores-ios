

import SwiftUI

struct DoneButtonView: View {
    var width : CGFloat
    var body: some View {
        ZStack{
            Capsule()
                .fill(Color.black)
            Text("Done").font(.caption).foregroundColor(.white)
        }.frame(width:width, height: 30)
    }
}

#Preview {
    DoneButtonView(width:70)
}
