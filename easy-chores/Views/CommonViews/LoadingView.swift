

import SwiftUI

struct LoadingView: View {
    var body: some View {
        GeometryReader{_ in
            VStack(alignment: .center){
                Text("Loading...")
            }
        }
    }
}

#Preview {
    LoadingView()
}
