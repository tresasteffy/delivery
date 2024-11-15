//
//  ProductCell.swift
//  delivery
//
//  Created by apple on 15/11/24.
//
import SwiftUI

struct ProductCell: View {
    let category: Category
    let product: ProductService
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text("\(product.finalPrice) \(product.regularPrice)")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
