//
//  CategoryGrid.swift
//  delivery
//
//  Created by apple on 15/11/24.
//

import Foundation
import SwiftUI


struct CategoryGrid: View {
    let categories: [DataClass]

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 20) {
            ForEach(categories, id: \.id) { category in
                categoryView(for: category)
            }
        }
        .padding(.horizontal)
    }
}
private func categoryView(for category: DataClass) -> some View {
    NavigationLink(destination: VendorDetailsView(category: category)) {
        CategoryCell(category: category)
    }
    .buttonStyle(PlainButtonStyle())
}
