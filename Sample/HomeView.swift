//
//  HomeView.swift
//  Sample
//
//  Created by User on 10/11/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            switch selectedIndex {
            case 0:
                SearchBarView()
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.banners, id: \.uid) { banner in
                            switch banner.type {
                            case "banner_slider":
                                BannerSlider(banners: banner.contents!)
                            case "products":
                                ProductsSection(title: banner.title, products: banner.contents!)
                            case "banner_single":
                                SingleBanner(bannerImageUrl: banner.imageUrl!)
                            case "categories":
                                CategoriesSection(categories: banner.contents!, title: banner.title)
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
            case 1,2,3,4:
                VStack {
                    Text("Coming Soon...")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            default:
                Text("")
            }
            
            Spacer()
            BottomBar(selectedIndex: $selectedIndex)
                .padding(.bottom, 0)
        }
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

#Preview {
    HomeView()
}
