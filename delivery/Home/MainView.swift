import SwiftUI
import Foundation

struct LocalizedStrings {
    static let deliveringTo = "Delivering to"
    static let points = "points"
    static let orderNow = "Order now"
    static let onlyOnTalabat = "Only on talabat!"
    static let yourFavorites = "Your all-time favorites\navailable in one place"
    static let retry = "Retry"
    static let errorTitle = "Error"
    static let unknownError = "Unknown error"
    static let home = "Home"
    static let search = "Search"
    static let account = "Account"
    static let weatherAlertMessage = "Delivery times might be affected due to the weather conditions. We apologize for any inconvenience."
}

struct LocationHeader: View {
    let location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(LocalizedStrings.deliveringTo)
                .foregroundColor(.gray)
            HStack {
                Text(location)
                    .font(.headline)
                Image(systemName: "chevron.down")
                    .foregroundColor(.orange)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "gift")
                        .foregroundColor(.blue)
                    Text("0 \(LocalizedStrings.points)")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white)
                .cornerRadius(20)
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct PromoBanner: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(LocalizedStrings.onlyOnTalabat)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(LocalizedStrings.yourFavorites)
                        .foregroundColor(.gray)
                    Button(action: {}) {
                        Text(LocalizedStrings.orderNow)
                            .foregroundColor(.orange)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                Image("promo-illustration")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            .background(
                Color.orange.opacity(0.1)
            )
        }
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct BottomNavBar: View {
    var body: some View {
        HStack {
            ForEach([LocalizedStrings.home, LocalizedStrings.search, LocalizedStrings.account], id: \.self) { tab in
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: tab == LocalizedStrings.home ? "house.fill" :
                            tab == LocalizedStrings.search ? "magnifyingglass" : "person")
                        .foregroundColor(tab == LocalizedStrings.home ? .orange : .gray)
                    Text(tab)
                        .font(.caption)
                        .foregroundColor(tab == LocalizedStrings.home ? .orange : .gray)
                }
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .shadow(radius: 2)
    }
}

struct MainView: View {
    @State private var showWeatherAlert = true
    let location = "Apartment (Salmiya)"
    @StateObject private var viewModel = VendorDetailsViewModel()

    private let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    LocationHeader(location: location)

                    ScrollView {
                        VStack(spacing: 20) {
                            PromoBanner()
                            if let data = viewModel.vendorData?.data{
                                CategoryGrid(categories: [data])
                            }

                        }
                    }

                    BottomNavBar()
                }

                if showWeatherAlert {
                    WeatherAlert(showAlert: $showWeatherAlert)
                }
            }
            .task {
                await viewModel.fetchVendorDetails()
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            )
            .alert(LocalizedStrings.errorTitle, isPresented: Binding(
                get: { viewModel.error != nil },
                set: { if !$0 { viewModel.error = nil } }
            )) {
                Text(viewModel.error?.localizedDescription ?? LocalizedStrings.unknownError)
            }
            .navigationBarHidden(true)
        }
    }
}
