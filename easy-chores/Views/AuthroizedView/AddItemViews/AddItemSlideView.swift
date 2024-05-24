
import SwiftUI

struct AddItemSlideView: View {
    @Binding var currentPage : CurrentPage
    @Binding var openSlide : Bool
    var body: some View {
        VStack(spacing:0){
            Color.black.opacity(0.5)
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .background(.black.opacity(0.5))
                .frame(width:.infinity,height:200)
                .overlay{
                    VStack(spacing:12){
                        HStack(spacing:24){
                            AddItemView(text: "Add Chores",image:"washer"){
                                currentPage = .chore
                                openSlide = false
                            }
                            AddItemView(text: "Add Groceries",image:"cart"){
                                currentPage = .grocery
                                openSlide = false
                            }
                        }
                        Button(action:{withAnimation{openSlide = false}}){
                            Text("Cancel").foregroundStyle(.customPrimary).underline()
                        }
                        Spacer()
                    }.padding(24)
                }
        }.frame(width:.infinity)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    AddItemSlideView(currentPage: .constant(.home), openSlide: .constant(true)).environment(\.font, Font.custom("Poppins-Regular",size:14))
}
