
import SwiftUI

struct AddButtonContainerView: View {
    @Binding var openAddPopUp : Bool
    @Binding var addItemPage : AddItemPage
    
    var body: some View {
            VStack{
                Spacer()
                if openAddPopUp {
                    HStack(spacing:20){
                        AddItemPopUpView(text: "Add Chores"){
                            addItemPage = .chore
                            openAddPopUp = false
                        }
                        AddItemPopUpView(text: "Add Groceries"){
                            addItemPage = .grocery
                            openAddPopUp = false
                        }
                        
                    }
                }
                Button(action: {openAddPopUp.toggle()}) {
                    Rectangle()
                        .opacity(0)
                        .overlay{
                        VStack{
                            Image(systemName: "plus.circle.fill").resizable().scaledToFit()
                            Text("Add").font(.caption)
                        }
                    }.frame(width:80,height:60)
                }
            }.foregroundColor(.black)
        
    }
}

