import SwiftUI

enum GroupPageSelection{
    case editGroup
    case createGroup
}

struct GroupSlideView: View {
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
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.customSecondary)
                            .frame(width:342,height:90)
                            .overlay{
                                VStack(alignment: .leading,spacing: 12){
                                    Button(action: {withAnimation{
                                        currentPage = .editGroup
                                        currentSlide = .none
                                    }}){
                                        HStack(spacing:14){
                                            Image(systemName:"pencil")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:18,height:18)
                                            Text("Edit group")
                                        }
                                    }.padding(.leading,16)
                                    Divider()
                                    Button(action: {withAnimation{
                                        currentPage = .createGroup
                                        currentSlide = .none
                                    }}){
                                        HStack(spacing:14){
                                            Image(systemName:"plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:18,height:18)
                                            Text("Create group")
                                        }
                                    }.padding(.leading,16)
                                }.foregroundStyle(.black)
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

#Preview {
    GroupSlideView(currentPage: .constant(.home), currentSlide: .constant(.group))
}
