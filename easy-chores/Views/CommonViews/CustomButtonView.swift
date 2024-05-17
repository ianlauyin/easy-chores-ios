

import SwiftUI

struct CustomButtonView: View {
    var width : CGFloat
    var text : String
    var onClick : ()->Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.black)
                .frame(width:width,height:40)
        }.overlay{
            Text(text).font(.subheadline).foregroundColor(.white)
        }
    }
}

