import SwiftUI

struct AuthroizedTabView: View {
    @Binding var currentPage : CurrentPage
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            HStack(alignment:.top, spacing:15){
                Button(action:{
                    currentPage = .home}){
                        VStack(spacing:2){
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width:30,height:30)
                            Text("Home")
                                .font(.footnote)
                        }
                    }.padding(10)
                
                Button(action:{
                    currentPage = .calendar}){
                    VStack(spacing:2){
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30,height:30)
                        Text("Calendar")
                            .font(.footnote)
                        }
                    }.padding(10)
                
                Spacer().frame(width:30).padding(10)
                
                Button(action:{
                    currentPage = .notice}){
                    VStack(spacing:2){
                        Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30,height:30)
                        Text("Notice")
                            .font(.footnote)
                        }
                    }.padding(10)
                
                Button(action:{
                    currentPage = .profile}){
                        VStack(spacing:2){
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width:30,height:30)
                            Text("Profile")
                                .font(.footnote)
                        }
                    }.padding(10)
            }.foregroundStyle(.gray)
                .padding(.bottom,50)
        }.frame(height:100)
    }
}

