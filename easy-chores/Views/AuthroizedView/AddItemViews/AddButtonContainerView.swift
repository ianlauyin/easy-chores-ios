
import SwiftUI

struct AddButtonContainerView: View {
    @State var openPopUp : Bool = false
    @Binding var currentPage : CurrentPage
    
    var body: some View {
        VStack(alignment: .center){
                Spacer()
                if openPopUp {
                    HStack(spacing:20){
                        AddItemPopUpView(text: "Add Chores"){
                            currentPage = .chore
                            openPopUp = false
                        }
                        AddItemPopUpView(text: "Add Groceries"){
                            currentPage = .grocery
                            openPopUp = false
                        }
                    }
                }
                Button(action: {openPopUp.toggle()}) {
                    Rectangle()
                        .opacity(0)
                        .overlay{
                            VStack(alignment:.center){
                            Image(systemName: "plus.circle.fill").resizable().scaledToFit()
                                .frame(width:80)
                            Text("Add").font(.footnote)
                        }
                    }
                }
                .frame(width:100,height:60)
            }.foregroundColor(.black)
        
    }
}


