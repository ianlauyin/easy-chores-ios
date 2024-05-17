

import SwiftUI

struct DoneButtonView: View {
    var width : CGFloat
    var onClick : ()->Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.black)
                .frame(width:width,height:30)
        }.overlay{
            Text("Done").font(.caption).foregroundColor(.white)
        }
    }
}

