
import SwiftUI

struct CustomTextFieldView: View {
    @FocusState var focus : Bool
    @Binding var input : String
    var placeholder : String
    var width : CGFloat = 339
    var secure : Bool = false
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .stroke(focus ? Color.customPrimary : Color.gray, lineWidth:1)
            .frame(width:width,height:49)
            .overlay{
                if secure{
                    SecureField(placeholder,text: $input)
                        .padding()
                        .focused($focus)
                }else{
                    TextField(placeholder,text: $input)
                        .padding()
                        .focused($focus)
                        .foregroundStyle(.customPrimary)
                }
            }
    }
}

