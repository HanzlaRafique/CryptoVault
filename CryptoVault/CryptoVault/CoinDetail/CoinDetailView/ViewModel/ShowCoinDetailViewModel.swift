//
//  ShowCoinDetailViewModel.swift
//  CryptoVault
//
//  Created by Hanzla Rafique on 9/25/24.
//

import Foundation
import Combine

class ShowCoinDetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticsModel] = []
    @Published var additionalStatistics: [StatisticsModel] = []
    @Published var coin: CoinsModel
    
    @Published var coinDescription: String?
    @Published var coinsLinks: String?
    @Published var coinRedditURL: String?
    
    
    var coinDetailService: CoinDetailService
    var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinsModel) {
        self.coin = coin
        coinDetailService = CoinDetailService(coinDetail: coin)
        fetchCoinDetail()
    }
    
    private func fetchCoinDetail() {
        
        coinDetailService.$detailCoin
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink(receiveValue: { (retunedAray) in
                self.overviewStatistics = retunedAray.overview
                self.additionalStatistics = retunedAray.additional
            })
            .store(in: &cancellable)
        
        coinDetailService.$detailCoin
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.coinsLinks = returnedCoinDetails?.links?.homepage?.first
                self?.coinRedditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellable)
    }
    
    
    private func mapDataToStatistic(coinDetailModel: CoinDescriptionModel?, coinModel: CoinsModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        
        let overViewStat = overViewStatistic(coinModel: coinModel)
        let additionalStat = additionalStatistic(coinDetailModel: coinDetailModel, coinModel: coinModel)
        return (overViewStat, additionalStat)
    }
    
    private func overViewStatistic(coinModel: CoinsModel) -> [StatisticsModel] {
        let price = coinModel.currentPrice?.asNumberString()
        let priceChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current Price", value: price, percentage: priceChange)
        
        let marketCab = "$" + Double(coinModel.marketCap ?? 0).formattedWithAbbreviations()
        let maketCapChange = coinModel.marketCapChangePercentage24H
        let maketStat = StatisticsModel(title: "Maket Capitalization", value: marketCab, percentage: maketCapChange)
        
        let rank = "\(coinModel.marketCapRank ?? 0)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "\(coinModel.totalVolume ?? 0)"
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        return [
            priceStat,
            maketStat,
            rankStat,
            volumeStat
        ]
        
    }
    
    private func additionalStatistic(coinDetailModel: CoinDescriptionModel?, coinModel: CoinsModel) -> [StatisticsModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "N/A"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange2 = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "N/A"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceStat2 = StatisticsModel(title: "24 Price Change", value: priceChange2, percentage: pricePercentChange2)
        
        let marketCab2 = "$" + Double(coinModel.marketCapChange24H ?? 0).formattedWithAbbreviations()
        let maketCapChange2 = coinModel.marketCapChangePercentage24H
        let maketStat2 = StatisticsModel(title: "24 Maket Cap Change", value: marketCab2, percentage: maketCapChange2)
        
        let block = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockString = block == 0 ? "N/A" : "\(block)"
        let blockStat = StatisticsModel(title: "Block Time", value: blockString)
        
        let hash = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashinStat = StatisticsModel(title: "Hashing Algorithm", value: hash)
        
        return [
            highStat,
            lowStat,
            priceStat2,
            maketStat2,
            blockStat,
            hashinStat
        ]
        
    }
}
