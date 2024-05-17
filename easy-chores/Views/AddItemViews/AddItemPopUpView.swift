
import SwiftUI

struct AddItemPopUpView: View {
    let text : String
    let onClick : ()->Void
    
    var body: some View {
        Button(action:onClick){
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .frame(width:140, height:70)
                .overlay{
                    VStack{
                        Text(text).font(.headline)
                        Image(systemName: "plus").resizable().scaledToFit()
                    }.padding(10)
                }
        }
    }
}
