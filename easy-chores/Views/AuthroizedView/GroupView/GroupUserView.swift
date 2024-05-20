
import SwiftUI

struct GroupUserView: View {
    var user : UserViewModel
    var onDelete : ()->Void
    
    var body: some View {
        Capsule()
            .fill(.white)
            .stroke(.black, lineWidth: 1)
            .frame(width:120,height:40)
            .overlay{
                HStack{
                    Text(user.username ?? user.email ?? "Unknown user")
                    Button(action : onDelete){
                        Image(systemName:"xmark")
                    }
                }
            }
    }
}
