import SwiftUI

struct ContentView: View {
    @State private var tapLocation: CGPoint = .zero
    @State private var rippleTrigger: Int = 0
    
    var body: some View {
        Image("octupus")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .modifier(RippleEffect(origin: tapLocation, trigger: rippleTrigger))
            .onTapGesture { location in
                tapLocation = location
                rippleTrigger += 1
            }
    }
}

#Preview {
    ContentView()
}
