

import SwiftUI

@main
struct easy_choresApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack{
                MainView()
                    .environment(\.font, Font.custom("Poppins-Regular", size: 14))
            }
        }
    }
}
