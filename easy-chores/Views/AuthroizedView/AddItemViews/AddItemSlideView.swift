
import SwiftUI

struct AddItemSlideView: View {
    @Binding var currentPage : CurrentPage
    @Binding var currentSlide : CurrentSlide
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
                                currentSlide = .none
                                currentPage = .chore
                            }
                            AddItemView(text: "Add Groceries",image:"cart"){
                                currentSlide = .none
                                currentPage = .grocery
                            }
                        }
                        Button(action:{withAnimation{currentSlide = .none}}){
                            Text("Cancel").foregroundStyle(.customPrimary).underline()
                        }
                        Spacer()
                    }.padding(24)
                }
        }.frame(width:.infinity)
            .ignoresSafeArea(.all)
    }
}
