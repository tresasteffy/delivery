//
//  LoadingView.swift
//  delivery
//
//  Created by apple on 14/11/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
}
