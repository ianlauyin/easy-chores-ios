import SwiftUI

struct AuthroizedTabView: View {
    @Binding var currentPage : CurrentPage
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            HStack(alignment:.top, spacing:15){
                Button(action:{
                    currentPage = .home}){
                        VStack(spacing:6){
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:40,height:40)
                            Text("Home")
                        }
                    }.padding(10)
                    .foregroundStyle(currentPage == .home ? .customPrimary : .gray)
                
                Button(action:{
                    currentPage = .calendar}){
                    VStack(spacing:6){
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width:40,height:40)
                        Text("Calendar")
                        }
                    }.padding(10)
                    .foregroundStyle(currentPage == .calendar ? .customPrimary : .gray)
                
                Spacer().frame(width:30).padding(10)
                
                Button(action:{
                    currentPage = .notice}){
                    VStack(spacing:6){
                        Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width:40,height:40)
                        Text("Notice")
                            
                        }
                    }.padding(10)
                    .foregroundStyle(currentPage == .notice ? .customPrimary : .gray)
                
                Button(action:{
                    currentPage = .profile}){
                        VStack(spacing:6){
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width:40,height:40)
                            Text("Profile")
                        }
                    }.padding(10).foregroundStyle(currentPage == .profile ? .customPrimary : .gray)
            }.padding(.bottom,50)
        }.frame(height:115)
            .font(Font.custom("Poppins-Regular",size:12))
    }
}

#Preview{
    AuthroizedTabView(currentPage: .constant(CurrentPage.home)).environment(\.font, Font.custom("Poppins-Regular",size:14))
}
