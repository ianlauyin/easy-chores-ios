import SwiftUI

enum GroupPageSelection{
    case editGroup
    case createGroup
}

struct GroupMenuView: View {
    var onClick : ()->Void
    @State var groupPage : GroupPageSelection? = nil
    var body: some View {
        Rectangle()
                .fill(.white)
                .overlay{
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:onClick){
                                Image(systemName:"xmark")
                            }
                        }.padding(.horizontal)
                        VStack(alignment:.leading){
                            NavigationLink(value: GroupPageSelection.editGroup) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .overlay{
                                        Text("Edit group")
                                    }
                            }
                            NavigationLink(value: GroupPageSelection.createGroup) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .overlay{
                                        Text("Add new group")
                                    }
                            }
                        }.padding()
                    }
        }.frame(height:200)
            .navigationDestination(for: GroupPageSelection.self) { selection in
                switch selection {
                case .editGroup: EditGroupView()
                case .createGroup: CreateGroupView()
                }
            }
    }
}

#Preview {
    GroupMenuView(){()}
}
