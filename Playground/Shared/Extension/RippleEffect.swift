import SwiftUI

/// Bridges SwiftUI state to Metal shader parameters
struct RippleModifier: ViewModifier {
    var origin: CGPoint
    var elapsedTime: TimeInterval
    var duration: TimeInterval
    
    // Physics parameters
    var amplitude: Double = 12
    var frequency: Double = 15
    var decay: Double = 8
    var speed: Double = 1200
    
    func body(content: Content) -> some View {
        let shader = ShaderLibrary.Ripple(
            .float2(origin),
            .float(elapsedTime),
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
        )
        
        // Calculate max offset to prevent clipping
        let maxSampleOffset = CGSize(width: amplitude, height: amplitude)
        
        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                isEnabled: 0 < elapsedTime && elapsedTime < duration
            )
        }
    }
}

/// Drives the ripple animation using KeyframeAnimator
struct RippleEffect<T: Equatable>: ViewModifier {
    var origin: CGPoint
    var trigger: T
    var duration: TimeInterval = 3
    
    func body(content: Content) -> some View {
        content.keyframeAnimator(
            initialValue: 0,
            trigger: trigger
        ) { view, elapsedTime in
            view.modifier(RippleModifier(
                origin: origin,
                elapsedTime: elapsedTime,
                duration: duration
            ))
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(duration, duration: duration)
        }
    }
}

extension View {
    /// Apply a ripple effect triggered by tap gestures
    func rippleEffect<T: Equatable>(at origin: CGPoint, trigger: T, duration: TimeInterval = 3) -> some View {
        modifier(RippleEffect(origin: origin, trigger: trigger, duration: duration))
    }
}
