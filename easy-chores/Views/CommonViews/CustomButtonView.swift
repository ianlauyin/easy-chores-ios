

import SwiftUI

struct CustomButtonView: View {
    var width : CGFloat
    var height: CGFloat
    var text : String
    var onClick : ()->Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 40)
                .fill(.customPrimary)
                .frame(width:width,height:height)
        }.overlay{
            Text(text).font(.system(size: 16)).foregroundColor(.white).bold()
        }
    }
}

