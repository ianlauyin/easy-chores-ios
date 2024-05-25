
import SwiftUI

struct GroupUserView: View {
    var user : UserViewModel
    var onDelete : ()->Void
    
    var body: some View {
        Capsule()
            .fill(.customAccent)
            .frame(width:100,height:30)
            .overlay{
                HStack{
                    Text(user.username ?? user.email ?? "Unknown user")
                    Button(action : onDelete){
                        Image(systemName:"xmark")
                    }
                }.foregroundStyle(.white)
            }
    }
}

#Preview {
    GroupUserView(user: UserViewModel(id:1,username:"Ian")){()}
}
