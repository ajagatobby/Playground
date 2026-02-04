import SwiftUI

struct ContentView: View {
    @State private var tapLocation: CGPoint = .zero
    @State private var rippleTrigger: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            Image("octupus")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .contentShape(Rectangle())
                .drawingGroup()
                .modifier(RippleEffect(origin: tapLocation, trigger: rippleTrigger))
                .onTapGesture { location in
                    tapLocation = location
                    rippleTrigger += 1
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
