//
//  Home.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/15/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var isShowPortfolio = true
    @State var showPortfolioView = false
    @State private var selectedCoin: CoinsModel? = nil
    @State var showDetailView = false
    @State var showSettingView = false
    
    
    var body: some View {
        
        ZStack {
            
            Color.thems.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    EditPortfolioView()
                        .environmentObject(vm)
                })
            
            VStack {
                homeHeader
                Spacer()
                HomeStatisticsView(showPortfolio: $isShowPortfolio)
                SearchView(serachText: $vm.searchTxt)
                
                coinHeaders
                    .padding(.horizontal)
                
                if isShowPortfolio {
                    portfolioView
                        .transition(.move(edge: .trailing))
                    
                } else {
                    coinListView
                        .transition(.move(edge: .leading))
                }
            } 
            .sheet(isPresented: $showSettingView, content: {
                SettingView()
            })
        }
        .background(NavigationLink("",
                           destination: LoadDetailView(coin: $selectedCoin),
                           isActive: $showDetailView))
    }
}

#Preview {
    
    NavigationView(content: {
        HomeView()
    })
    .environmentObject(DeveloperView.instance.homeVM)
}


extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(imageName: isShowPortfolio ? "plus" : "info")
                .onTapGesture {
                    if isShowPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingView.toggle()
                    }
                }
                .background {
                    CircleButtonAnimation(isAnimate: $isShowPortfolio)
                }
            Spacer()
            
            Text(isShowPortfolio ? "Portfolio" : "Live Price")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.thems.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isShowPortfolio.toggle()
                    }
                }
           
        }
        .padding(.horizontal)
    }
    
    
    private var portfolioView: some View {
        
        List {

            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showColum: true)
                    .onTapGesture {
                        moveToDetailView(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var coinListView: some View {
        
        List {
            ForEach(vm.coinsList) { coin in
                CoinRowView(coin: coin, showColum: false)
                    .onTapGesture {
                        moveToDetailView(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
        
    }
    
    private func moveToDetailView(coin: CoinsModel?) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var coinHeaders: some View {
        HStack {
            
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortBy == .rank || vm.sortBy == .rankReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortBy == .rank ? 180 : 0))
            }
            .onTapGesture {
                withAnimation(.bouncy) {
                    vm.sortBy = vm.sortBy == .rank ? .rankReversed : .rank
                }
                
            }
            
            Spacer()
            
            if isShowPortfolio {
                HStack(spacing: 4) {
                    Text("Holding")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortBy == .holdings || vm.sortBy == .holdingsReversed ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortBy == .holdings ? 180 : 0))
                }
                .onTapGesture {
                    withAnimation(.bouncy) {
                        vm.sortBy = vm.sortBy == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            Spacer()
            
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortBy == .price || vm.sortBy == .priceReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortBy == .price ? 180 : 0))
            }
            .onTapGesture {
                withAnimation(.bouncy) {
                    vm.sortBy = vm.sortBy == .price ? .priceReversed : .price
                }
            }
            
            Button(action: {
                
                withAnimation(.linear(duration: 0.2)) {
                    vm.reloadData()
                }
                
            }, label: {
                Image(systemName: "circle.hexagonpath.fill")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            
            
        }
        .bold()
        .font(.headline)
        .padding(.horizontal)
    }
    
    
}
