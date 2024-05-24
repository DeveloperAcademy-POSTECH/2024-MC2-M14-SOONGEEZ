
import SwiftUI

struct SplashView: View {
    @State var LoginFinsh = false
    
    var body: some View {
        
        if !LoginFinsh {
            LoginView(LoginFinsh: $LoginFinsh)
        }
        
        else {
            ControlView()
        }

    }
}

#Preview {
    SplashView()
}
