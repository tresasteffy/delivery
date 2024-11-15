//
//  VendorViewModel.swift
//  delivery
//
//  Created by apple on 14/11/24.
//

import Foundation
@MainActor
class VendorDetailsViewModel: ObservableObject {
    @Published var vendorData: VendorResponse?
    @Published var isLoading = false
    @Published var error: VendorError?

    func fetchVendorDetails() async {
            do {
                let endpoint = Endpoint.vendorDetails(vendorID: 44, lang: "en", userID: 50)
                vendorData = try await NetworkManager.shared.request(endpoint)
            } catch let networkError as VendorError {
                error = networkError
            } catch {
//                error = .networkError(error.localizedDescription)
            }
        }
}
