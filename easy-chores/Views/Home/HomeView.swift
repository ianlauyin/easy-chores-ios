
import SwiftUI

struct HomeView: View {
    var user : UserViewModel

    init(user:UserViewModel){
        self.user = user
    }
    var body: some View {
        VStack{
            Text("Welcome! \(user.user.username)")
            
        }
    }
}

let previewUser = UserViewModel(id: 1, username: "Ian")
#Preview {
    HomeView(user:previewUser)
}
