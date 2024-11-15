import SwiftUI


struct VendorDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let category: DataClass
    @State private var selectedTab: String = ""
    @State private var headerHeight: CGFloat = 200
    @State private var scrollOffset: CGFloat = 0
    @Namespace private var namespace
    
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var loading: Bool = true
    
    private let maxHeaderHeight: CGFloat = 200
    private let minHeaderHeight: CGFloat = 0
    private let tabHeight: CGFloat = 50
    private let buttonBackgroundColor = Color.orange
    private let textColor = Color.black
    private let dividerColor = Color.gray.opacity(0.3)
    private let headerBackgroundColor = Color.clear
    private let headerCornerRadius: CGFloat = 16
    private let shadowRadius: CGFloat = 5
    private let bottomViewBackgroundColor = Color.white
    
    private let logoURL = "http://eindi.thecodelab.me//storage//uploads//vendors//original//logo-1720713153.png"
    private let placeholderColor = Color.gray.opacity(0.6)
    private let productCellSpacing: CGFloat = 24
    private let headerFontSize: CGFloat = 22
    private let sectionBackgroundOpacity: CGFloat = 0.6
    private let productServiceStarRating: String = "4.5"
    private let deliveryText = "Get Free delivery with pro"
    private let subscribeText = "subscribe"
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        Color.clear
                            .frame(height: headerHeight)
                            .background(
                                GeometryReader { geo in
                                    let offset = geo.frame(in: .global).minY
                                    DispatchQueue.main.async {
                                        updateHeaderHeight(with: offset)
                                    }
                                    return Color.clear
                                }
                            )
                        
                        VStack(spacing: 0) {
                            Color.clear
                                .frame(height: tabHeight)
                            
                            if loading {
                                SkeletonLoader()
                            } else {
                                productContent
                                    .padding(.top)
                            }
                        }
                    }
                    .onAppear {
                        scrollProxy = proxy
                        if selectedTab.isEmpty && !category.categories.isEmpty {
                            selectedTab = category.categories.first?.id ?? ""
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            loading = false
                        }
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                GeometryReader { geo in
                    let minY = geo.frame(in: .global).minY
                    let sectionOffsets = category.categories.map { service in
                        SectionOffset(id: service.id?.description ?? "", minY: minY)
                    }
                    updateSelectedTab(sectionOffsets)
                    return Color.clear
                }
            )
            
            VStack(spacing: 0) {
                if headerHeight > 0 {
                    headerView
                        .frame(height: headerHeight)
                        .clipped()
                        .zIndex(0)
                }
                
                tabView
                    .background(bottomViewBackgroundColor)
                    .overlay(Divider(), alignment: .bottom)
                    .zIndex(1)
            }
            VStack {
                Spacer()
                BottomView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                
                Button(action: {
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
    
    
    
    struct BottomView: View {
        
        private let footerTextColor = Color.pink
        private let footerButtonTextColor = Color.white
        private let footerButtonBackgroundColor = Color.orange
        private let bottomViewBackgroundColor = Color.white
        
        private let saveText = "Save upto kd3"
        private let timeText = "24:53"
        private let startSavingText = "Start saving by adding items to the basket"
        private let viewBasketText = "View Basket"
        private let priceText = "Kd 0.00"
        
        var body: some View {
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "diamond.fill")
                            .foregroundColor(.yellow)
                        Text(saveText)
                            .font(.footnote)
                            .foregroundColor(.black)
                        Spacer()
                        Text(timeText)
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                    Divider()
                    Text(startSavingText)
                        .font(.footnote)
                        .foregroundColor(footerTextColor)
                    
                    Button(action: {
                    }) {
                        HStack{
                            Text(viewBasketText)
                                .font(.headline)
                                .foregroundColor(footerButtonTextColor)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(footerButtonBackgroundColor)
                                .cornerRadius(10)
                                .padding([.leading, .trailing], 6)
                            
                            Spacer()
                            Text(priceText)
                                .font(.headline)
                                .foregroundColor(footerButtonTextColor)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(footerButtonBackgroundColor)
                                .cornerRadius(10)
                                .padding([.leading, .trailing], 6)
                        }
                    }
                }
                .padding([.leading, .trailing], 16)
                .background(bottomViewBackgroundColor)
                .shadow(radius: 5)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    
    private var headerView: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: logoURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: headerHeight / 2)
            } placeholder: {
                placeholderColor
            }
            
            Color.white
                .frame(height: headerHeight / 2)
                .overlay(
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            VStack {
                                
                                Text(category.name.rawValue )
                                    .font(.system(size: headerFontSize))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(3)
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(productServiceStarRating)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        if headerHeight > 20 {
                            infoSection
                                .opacity(calculateInfoOpacity())
                                .transition(.opacity)
                            HStack {
                                Text(deliveryText)
                                    .cornerRadius(10)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                Text(subscribeText)
                                    .cornerRadius(10)
                                    .foregroundColor(.blue)
                            }
                            .frame(height: 20)
                            .padding(.horizontal)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.bottom,10)
                        }
                    }
                        .padding(.horizontal)
                        .background(Color.black.opacity(sectionBackgroundOpacity))
                        .cornerRadius(8)
                        .padding(.bottom, 65)                  )
        }
        .background(
            RoundedRectangle(cornerRadius: headerCornerRadius, style: .continuous)
                .fill(headerBackgroundColor)
                .shadow(radius: shadowRadius)
        )
        .clipped()
    }
    
    private var productContent: some View {
        VStack(spacing: productCellSpacing) {
            ForEach(category.categories) { category in
                VStack(alignment: .leading, spacing: 16) {
                    Text(category.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .id(category.id)
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(
                                    key: SectionOffsetPreferenceKey.self,
                                    value: [SectionOffset(id: category.id ?? "", minY: geo.frame(in: .named("scroll")).minY)]
                                )
                            }
                        )
                    
                    ForEach(category.productServices) { product in
                        ProductCell(category: category, product: product)
                    }
                }
            }
        }
        .onPreferenceChange(SectionOffsetPreferenceKey.self) { sectionOffsets in
            updateSelectedTab(sectionOffsets)
        }
    }
    
    
    
    
    private var infoSection: some View {
        
        let deliveryFee = "Delivery Fee"
        let deliverPrice = "KD 0.500"
        let deliveryTime = "Delivery Time"
        let time = "30-45 min"
        let deliveredBy = "Delivered by"
        let talabat = "talabat"
        
        return HStack(spacing: 16) {
            VStack {
                Text(deliveryFee)
                Text(deliverPrice)
            }
            
            VStack {
                Text(deliveryTime)
                Text(time)
            }
            
            VStack {
                Text(deliveredBy)
                Text(talabat)
            }
        }
        .foregroundColor(.white)
        .font(.subheadline)
    }
    
    private var tabView: some View {
        ScrollViewReader { tabProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(category.categories) { category in
                        CategoryTabView(
                            name: category.name,
                            isSelected: selectedTab == category.id
                        )
                        .id(category.id)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = category.id ?? ""
                                scrollToSection(id: category.id ?? "")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: tabHeight)
            .onChange(of: selectedTab) { newTab in
                withAnimation {
                    tabProxy.scrollTo(newTab, anchor: .center)
                }
            }
        }
    }
    
    
    private func scrollToSection(id: String) {
        withAnimation {
            scrollProxy?.scrollTo(id, anchor: .top)
        }
    }
    
    private func updateSelectedTab(_ sectionOffsets: [SectionOffset]) {
        guard let closest = sectionOffsets.min(by: { abs($0.minY) < abs($1.minY) }) else { return }
        selectedTab = closest.id
    }
    
    private func updateHeaderHeight(with offset: CGFloat) {
        let newHeight = maxHeaderHeight + offset
        
        withAnimation(.interactiveSpring()) {
            headerHeight = max(minHeaderHeight, min(maxHeaderHeight, newHeight))
        }
    }
    
    private func calculateInfoOpacity() -> Double {
        let progress = (headerHeight) / (maxHeaderHeight)
        return Double(max(0, min(1, progress)))
    }
    
    private func calculateFontSize() -> CGFloat {
        return headerHeight > 130 ? 22 : 20
    }
}


