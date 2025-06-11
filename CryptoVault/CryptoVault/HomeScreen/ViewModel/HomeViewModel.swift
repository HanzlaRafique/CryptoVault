//
//  HomeViewModel.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 8/16/24.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject, Identifiable {
    
    @Published var coinsList: [CoinsModel] = []
    @Published var portfolioCoins: [CoinsModel] = []
    @Published var searchTxt: String = ""
    @Published var isLoading = false
    @Published var sortBy: SortBy = .holdings
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var statistics: [StatisticsModel] = []
    
    var coinDataService = CoinDataService()
    var marketDataService = MarketDataService()
    var portfolioDataService = PortfolioDataService()
    var coinsCancel = Set<AnyCancellable>()
    
    init() {
        dataBinding()
    }
    
    
    func dataBinding() {
        
        $searchTxt
            .combineLatest(coinDataService.$allCoins, $sortBy)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(coinFilterAndSorted)
            .sink { returnCoins in
                self.coinsList = returnCoins
            }
            .store(in: &coinsCancel)
        
        $coinsList
            .combineLatest(portfolioDataService.$savedEntries)
            .map(mapAllCoinsPortfolio)
            .sink { [weak self] (coinsList) in
                self?.portfolioCoins = coinsList
            }
            .store(in: &coinsCancel)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
                HapticManager.notification(notificationType: .success)
            }
            .store(in: &cancellables)
    }
    
    private func mapAllCoinsPortfolio(coin: [CoinsModel], coinEntries: [PortfolioEntity]) -> [CoinsModel] {
        coin
            .compactMap { (coin) -> CoinsModel? in
                guard let entry = coinEntries.first(where: {$0.id == coin.id}) else {return nil}
                return coin.updateHoldings(amount: entry.amount)
            }
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoinsData()
        marketDataService.getMarketData()
    }
    
    func updatePortfolio(coin: CoinsModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func coinFilterAndSorted(txt: String, coins: [CoinsModel], sortBy: SortBy) -> [CoinsModel] {
        
        var updatedCoin = filterTheCoins(txt: txt, coins: coins)
        sortedCoins(sortedBy: sortBy, coins: &updatedCoin)
        return updatedCoin
        
    }
    
    private func sortedCoins(sortedBy: SortBy, coins: inout [CoinsModel]) {
        
        switch sortedBy {
            
        case .rank, .holdings:
            coins.sort(by: {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 0})
            
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.marketCapRank ?? 0 > $1.marketCapRank ?? 0})
           
        case .price:
            coins.sort(by: {$0.priceChange24H ?? 0 > $1.priceChange24H ?? 0})
            
        case .priceReversed:
            coins.sort(by: {$0.priceChange24H ?? 0 < $1.priceChange24H ?? 0})
        }
        
    }
    
    private func filterTheCoins(txt: String, coins: [CoinsModel]) -> [CoinsModel] {
        
        guard !txt.isEmpty else {
            return coins
        }
        
        let lowerCase = txt.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name?.lowercased().contains(lowerCase) ?? false ||
                    coin.id?.lowercased().contains(lowerCase) ?? false ||
                    coin.symbol?.lowercased().contains(lowerCase) ?? false
        }
    }
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinsModel]) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
    
        guard let data = marketDataModel?.data else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentage: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = portfolioCoins.map({ Int($0.currentHoldings ?? 0) }).reduce(0, +)
        
        let previousValue =
            portfolioCoins
                .map { (coin) -> Double in
                    let currentValue = coin.currentHoldings
                    let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                    let previousValue = (currentValue ?? 0) / (1 + percentChange)
                    return previousValue
                }
                .reduce(0, +)

        let percentageChange = ((Double(portfolioValue) - previousValue) / previousValue)
        
        let portfolio = StatisticsModel(
            title: "Portfolio Value",
            value: String(portfolioValue),
            percentage: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
