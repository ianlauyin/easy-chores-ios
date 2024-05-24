import SwiftUI

struct AuthroizedTabView: View {
    @Binding var currentPage : CurrentPage
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Divider()
                HStack(alignment:.top, spacing: 0){
                    Button(action:{
                        currentPage = .home}){
                            VStack(spacing:6){
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30,height:30)
                                Text("Home")
                            }
                        }.frame(width:geometry.size.width/5)
                        .foregroundStyle(currentPage == .home ? .customPrimary : .gray)
                    
                    Button(action:{
                        currentPage = .calendar}){
                            VStack(spacing:6){
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30,height:30)
                                Text("Calendar")
                            }
                        }.frame(width:geometry.size.width/5)
                        .foregroundStyle(currentPage == .calendar ? .customPrimary : .gray)
                    Spacer().frame(width:geometry.size.width/5)
                    Button(action:{
                        currentPage = .notice}){
                            VStack(spacing:6){
                                Image(systemName: "bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30,height:30)
                                Text("Notice")
                                
                            }
                        }.frame(width:geometry.size.width/5)
                        .foregroundStyle(currentPage == .notice ? .customPrimary : .gray)
                    
                    Button(action:{
                        currentPage = .profile}){
                            VStack(spacing:6){
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30,height:30)
                                Text("Profile")
                            }
                        }.frame(width:geometry.size.width/5)
                        .foregroundStyle(currentPage == .profile ? .customPrimary : .gray)
                }
            }.padding(.bottom,50)
        }.frame(height:115)
        .font(Font.custom("Poppins-Regular",size:12))
    }
}

#Preview{
    AuthroizedTabView(currentPage: .constant(CurrentPage.home)).environment(\.font, Font.custom("Poppins-Regular",size:14))
}
