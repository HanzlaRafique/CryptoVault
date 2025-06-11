//
//  MarketDataService.swift
//  CryptoVault
//
//  Created by Hanzla Rafique 9/16/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var cancellable: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        cancellable = NetworkManager.download(url: url)
            .decode(type: MarketDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in NetworkManager.handlerCompletion(completion: completion)
            }, receiveValue: { [weak self] data in
                self?.marketData = data
                self?.cancellable?.cancel()
            })
    }
}
