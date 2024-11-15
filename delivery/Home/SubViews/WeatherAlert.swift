//
//  File.swift
//  delivery
//
//  Created by apple on 15/11/24.
//

import Foundation
import SwiftUI

struct WeatherAlert: View {
    @Binding var showAlert: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(LocalizedStrings.weatherAlertMessage)
                    .foregroundColor(.gray)
                    .padding()
                Button(action: { showAlert = false }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding()
            .padding(.bottom, 60)
        }
        .transition(.move(edge: .bottom))
    }
}

