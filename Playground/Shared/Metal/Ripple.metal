#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[ stitchable ]] half4 Ripple(
    float2 position,
    SwiftUI::Layer layer,
    float2 origin,
    float time,
    float amplitude,
    float frequency,
    float decay,
    float speed
) {
    // 1. Calculate distance from touch origin
    float distance = length(position - origin);
    
    // 2. Calculate delay (propagation speed)
    float delay = distance / speed;
    
    // 3. Adjust time based on delay; clamp to 0 so waves don't appear before they arrive
    time -= delay;
    time = max(0.0, time);
    
    // 4. Calculate ripple displacement using Sinewave + Decay
    float rippleAmount = amplitude * sin(frequency * time) * exp(-decay * time);
    
    // 5. Calculate direction vector from origin to pixel
    float2 n = normalize(position - origin);
    
    // 6. Calculate new sample position
    float2 newPosition = position + rippleAmount * n;
    
    // 7. Sample the color at the distorted position
    half4 color = layer.sample(newPosition);
    
    // 8. Add light/shadow effect based on amplitude (Refraction simulation)
    // We use the alpha channel to ensure we don't light up transparent areas
    color.rgb += 0.3 * (rippleAmount / amplitude) * color.a;
    
    return color;
}
