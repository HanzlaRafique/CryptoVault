//
//  DetailView.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/25/24.
//

import SwiftUI


struct LoadDetailView: View {
    
    @Binding var coin: CoinsModel?
    
    var body: some View {
        VStack {
            
            if let coin = coin {
                ShowCoinDetailView(coin: coin)
            }
        }
    }
}

struct ShowCoinDetailView: View {
    
    @StateObject var vm: ShowCoinDetailViewModel
    @State var showFullDescription = false
    
    var gridItem: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var spacing: CGFloat = 30
    
    init(coin: CoinsModel) {
        _vm = StateObject(wrappedValue: ShowCoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView  {
            
            VStack {
                CoinChartView(coinData: vm.coin)
                VStack {
                    overviewTitle
                    descriptionDetail
                    overviewGrid
                    additionalTitle
                    additionalGrid
                    
                    VStack(alignment: .leading) {
                        
                        if let link = vm.coinsLinks, 
                        let url = URL(string: link) {
                            
                            Link("Website", destination: url)
                            
                        }
                        
                        if let link = vm.coinRedditURL,
                        let url = URL(string: link) {
                            Link("Reddit", destination: url)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            
        }
        .navigationTitle(vm.coin.name ?? "")
        .toolbar {
            
            ToolbarItem {
                HStack {
                    Text(vm.coin.symbol?.uppercased() ?? "")
                        .bold()
                    CoinImageView(coin: vm.coin)
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}

#Preview {
    NavigationView(content: {
        ShowCoinDetailView(coin: DeveloperView.instance.coin)
    })
}


extension ShowCoinDetailView {
    
    var overviewTitle: some View {
        
        VStack {
            Text("Overview")
                .bold()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.thems.accent)
            Divider()
        }
    }
    
    var overviewGrid: some View {
        LazyVGrid(
            columns: gridItem,
            alignment: .center,
            spacing: spacing,
            pinnedViews: []) {
           
                ForEach(vm.overviewStatistics) { overviewStat in
                    StatisticsView(statisticsModel: overviewStat)
                }
        }
    }
    
    var additionalTitle: some View {
        
        VStack {
            Text("Additional Details")
                .bold()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.thems.accent)
            
            Divider()
        }
    }
    
    var additionalGrid: some View {
        LazyVGrid(
            columns: gridItem,
            alignment: .center,
            spacing: spacing,
            pinnedViews: []) {
           
                ForEach(vm.additionalStatistics) { overviewStat in
                    StatisticsView(statisticsModel: overviewStat)
                }
        }
    }
    
    var descriptionDetail: some View {
        ZStack {
            
            if let coinDescription = vm.coinDescription,
                !coinDescription.isEmpty {
                
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ?  "See less..." : "See more...")
                            .font(.caption)
                            .bold()
                            .padding(.horizontal)
                            .foregroundStyle(Color.thems.accent)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
