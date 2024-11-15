//
//  ErrorView.swift
//  delivery
//
//  Created by apple on 14/11/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ErrorView: View {
    let error: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)

            Text(error)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: retryAction) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
}

