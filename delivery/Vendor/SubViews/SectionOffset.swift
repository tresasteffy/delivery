import SwiftUI

struct SectionOffset: Equatable {
    let id: String
    let minY: CGFloat
}

struct SectionOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [SectionOffset] = []
    
    static func reduce(value: inout [SectionOffset], nextValue: () -> [SectionOffset]) {
        value.append(contentsOf: nextValue())
    }
}


struct SkeletonLoader: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<5) { _ in
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 20)
                            .cornerRadius(4)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 15)
                            .cornerRadius(4)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 15)
                            .cornerRadius(4)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .redacted(reason: .placeholder)
        .padding(.top)
    }
}


