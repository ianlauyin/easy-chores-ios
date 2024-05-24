
import SwiftUI

struct AddButtonContainerView: View {
    @Binding var currentSlide : CurrentSlide
    @Binding var currentPage : CurrentPage
    
    var body: some View {
        VStack(alignment: .center){
                Spacer()
                Button(action: {withAnimation {currentSlide = .addItem}}) {
                    VStack(alignment:.center,spacing:6){
                        Image(systemName:
                                "plus.circle.fill").resizable().scaledToFit()
                                    .frame(width:50,height:50)
                                    .foregroundStyle(.customAccent)
                                Text("Add").font(Font.custom("Poppins-Regular",size:12))
                                    .foregroundColor(.black)
                            }
                }.frame(width:60,height:84)
                    .padding(50)
        }
    }
}


