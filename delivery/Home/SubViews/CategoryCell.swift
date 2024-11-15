//
//  CategoryCell.swift
//  delivery
//
//  Created by apple on 15/11/24.
//
import SwiftUI

struct CategoryCell: View {
    let category: DataClass
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)

                Text(category.id)
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .padding(8)

            }

            Text(category.name.rawValue)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}
