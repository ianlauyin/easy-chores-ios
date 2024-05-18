import SwiftUI

struct ErrorView: View {
    @EnvironmentObject private var errorManager : ErrorManager
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(width: 250,height:150)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .overlay(){
                VStack(spacing: 20){
                Text(errorManager.message ?? "Somethings is wrong")
                        .font(.headline)
                Button(action:{errorManager.message = nil}){
                    Text("Okay")
                }
            }
        }
        
    }
}

#Preview {
    ErrorView()
}
