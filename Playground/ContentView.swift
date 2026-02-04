import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Metal Effects") {
                    NavigationLink {
                        BasicRippleView()
                    } label: {
                        EffectRow(
                            title: "Ripple Effect",
                            description: "Tap to create water ripples",
                            systemImage: "drop.fill"
                        )
                    }
                    
                    NavigationLink {
                        ParticleEffectView()
                    } label: {
                        EffectRow(
                            title: "Particle Effect",
                            description: "Tap or drag to emit particles",
                            systemImage: "sparkles"
                        )
                    }
                }
            }
            .navigationTitle("Playground")
        }
    }
}

struct EffectRow: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(.purple)
                .frame(width: 40, height: 40)
                .background(.purple.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
