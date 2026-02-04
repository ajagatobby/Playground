import SwiftUI

struct BasicRippleView: View {
    @State private var tapLocation: CGPoint = .zero
    @State private var rippleTrigger: Int = 0
    
    // Buffer for ripple sampling at edges (should be >= amplitude)
    private let edgeBuffer: CGFloat = 30
    
    var body: some View {
        GeometryReader { geometry in
            let fullWidth = geometry.size.width + edgeBuffer * 2
            let fullHeight = geometry.size.height + edgeBuffer * 2
            
            Image("octupus")
                .resizable()
                .scaledToFill()
                .frame(width: fullWidth, height: fullHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .drawingGroup()
                .modifier(RippleEffect<Int>(origin: tapLocation, trigger: rippleTrigger))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .contentShape(Rectangle())
                .onTapGesture { location in
                    tapLocation = location
                    rippleTrigger += 1
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BasicRippleView()
}

