//
//  CategoryTabView.swift
//  delivery
//
//  Created by apple on 15/11/24.
//

import SwiftUI
struct CategoryTabView: View {
    let name: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Text(name)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .black : .gray)
                .padding(.horizontal, 8)
            
            Rectangle()
                .fill(isSelected ? Color.orange : Color.clear)
                .frame(height: 2)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
    }
}
