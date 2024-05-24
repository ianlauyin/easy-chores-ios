

import SwiftUI

struct CustomButtonView: View {
    var width : CGFloat
    var height: CGFloat
    var text : String
    var fontSize : CGFloat = 16
    var onClick : ()->Void
    
    var body: some View {
        Button(action: onClick){
            RoundedRectangle(cornerRadius: 40)
                .fill(.customPrimary)
                .frame(width:width,height:height)
        }.overlay{
            Text(text).font(Font.custom("Poppins-Regular",size:fontSize)).foregroundColor(.white).bold()
        }
    }
}

