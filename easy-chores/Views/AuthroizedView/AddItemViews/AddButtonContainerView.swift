
import SwiftUI

struct AddButtonContainerView: View {
    @State var openSlide : Bool = false
    @Binding var currentPage : CurrentPage
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Spacer()
                Button(action: {withAnimation {openSlide.toggle()}}) {
                    Rectangle()
                        .opacity(0)
                        .overlay{
                            VStack(alignment:.center,spacing:6){
                                Image(systemName: "plus.circle.fill").resizable().scaledToFit()
                                    .frame(width:60,height:60)
                                    .foregroundStyle(.customAccent)
                                Text("Add").font(Font.custom("Poppins-Regular",size:12))
                                    .foregroundColor(.black)
                            }
                        }
                }.frame(width:60,height:84)
                    .padding(50)
            }
            if openSlide {
                AddItemSlideView(currentPage:$currentPage, openSlide:$openSlide)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

#Preview {
    AddButtonContainerView(currentPage: .constant(.home)).environment(\.font, Font.custom("Poppins-Regular",size:14))
}

